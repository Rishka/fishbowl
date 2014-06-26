
require 'socket'
require 'digest'

require 'fishbowl/ext'

module Fishbowl # :nodoc:

  # to avoid complains about the top-level module
  # not existing, these are required inside the
  # module
  require 'fishbowl/errors'
  require 'fishbowl/requests'
  require 'fishbowl/version'
  require 'fishbowl/objects'

  class Connection

    attr_accessor :host, :port, :username, :password
    attr_reader :last_request, :last_response

    @connection = nil
    @ticket = nil

    def initialize(options = {})
      Rails.logger.info "Fishbowl::Connection#initialize"
      Rails.logger.info "Fishbowl::Connection#initialize PID #{Process.pid.inspect}"
      raise Errors::MissingHost if options[:host].nil?

      @host = options[:host]
      @port = options[:port] || 28192

      @connect_timeout = options[:connect_timeout] || 5.0
      @read_timeout = options[:read_timeout] || 30.0
      @write_timeout = options[:write_timeout] || 5.0
    end

    def connect
      Rails.logger.info "Fishbowl::Connection#connect PID #{Process.pid.inspect}"
      @connection = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
      sockaddr = Socket.sockaddr_in(@port, @host)

      begin
        Rails.logger.info "Fishbowl::Connection#connect"
        Rails.logger.info "Fishbowl::Connection#connect connection #{@connection.inspect}"
        Rails.logger.info "Fishbowl::Connection#connect sockaddr #{sockaddr.inspect}"
        @connection.connect_nonblock(sockaddr)
      rescue Errno::EINPROGRESS
        Rails.logger.info "Fishbowl::Connection#connect Errno::EINPROGRESS"
        if IO.select(nil, [@connection], nil, @connect_timeout)
          retry
        else
          @connection.close
          @connection = nil
          raise Errors::ConnectionTimeout
        end
      rescue Errno::EISCONN
        Rails.logger.info "Fishbowl::Connection#connect Errno::EISCONN"
        # connection completed successfully
      end

      self
    end

    def connected?
      Rails.logger.info "Fishbowl::Connection#connected? #{!!@connection.inspect}"
      Rails.logger.info "Fishbowl::Connection#connected? PID #{Process.pid.inspect}"
      !!@connection
    end

    def login(username, password)
      Rails.logger.info "Fishbowl::Connection#login username #{username.inspect}"
      Rails.logger.info "Fishbowl::Connection#login password #{password.inspect}"
      Rails.logger.info "Fishbowl::Connection#login connected? #{connected?.inspect}"
      Rails.logger.info "Fishbowl::Connection#login PID #{Process.pid.inspect}"
      raise Errors::ConnectionNotEstablished if !connected?
      raise Errors::MissingUsername if username.nil?
      raise Errors::MissingPassword if password.nil?

      @username, @password = username, password

      login_request = Requests::Login.new(
        :username => username,
        :password => password
      )

      clear_ticket

      begin
        Rails.logger.info "Fishbowl::Connection#login login_request #{login_request.inspect}"
        send_request(login_request)
      rescue
        Rails.logger.info "Fishbowl::Connection#login rescue"
        clear_ticket
        raise
      end

      Rails.logger.info "Fishbowl::Connection#login self #{self.inspect}"
      self
    end

    def send_request(request)
      Rails.logger.info "Fishbowl::Connection#send_request request #{request.inspect}"
      Rails.logger.info "Fishbowl::Connection#send_request connected? #{connected?.inspect}"
      Rails.logger.info "Fishbowl::Connection#send_request PID #{Process.pid.inspect}"
      raise Errors::ConnectionNotEstablished unless connected?

      request_builder = request.compose
      attach_ticket(request_builder)

      @last_request = request_builder.doc
      @last_response = nil

      Rails.logger.info "Fishbowl::Connection#send_request request_builder #{request_builder.inspect}"
      write(request_builder)
      Rails.logger.info "Fishbowl::Connection#send_request request #{request.inspect}"
      get_response(request)
    end

    def close
      Rails.logger.info "Fishbowl::Connection#close"
      Rails.logger.info "Fishbowl::Connection#close connection #{@connection.inspect}"
      Rails.logger.info "Fishbowl::Connection#close PID #{Process.pid.inspect}"
      @connection.close if @connection
      @connection = nil
      clear_ticket
      self
    end

    def has_ticket?
      Rails.logger.info "Fishbowl::Connection#close has_ticket? #{!!@ticket.inspect}"
      Rails.logger.info "Fishbowl::Connection#has_ticket? PID #{Process.pid.inspect}"
      !!@ticket
    end

    def clear_ticket
      Rails.logger.info "Fishbowl::Connection#clear_ticket PID #{Process.pid.inspect}"
      @ticket = nil
    end

    # Create utility proxies to requests, eg., will add method "add_inventory"
    # that builds and sends a Fishbowl::Requests::AddInventory
    Requests.constants.each do |c|
      module_constant = Requests.const_get(c)
      method_name = c.to_s.underscore.to_sym
      if module_constant.is_a?(Class) && !self.method_defined?(method_name)
        define_method method_name do |attributes = {}|
          Rails.logger.info "Fishbowl::Connection##{method_name} #{attributes.inspect}"
          Rails.logger.info "Fishbowl::Connection##{method_name} PID #{Process.pid.inspect}"
          request = module_constant.new(attributes)
          send_request(request)
        end
      end
    end

  private

    # This is kind of awkward, as we're adding the ticket into
    # the request from within the connection - would it be
    # better to make it a static property on the base request?
    # Or inject it to every `build` call?
    #
    # Not sure if the additional ticket information is required
    # on later calls (user ID, etc.)
    def attach_ticket(request_builder)
      Rails.logger.info "Fishbowl::Connection#attach_ticket #{request_builder.inspect}"
      Rails.logger.info "Fishbowl::Connection#attach_ticket ticket #{@ticket.inspect}"
      Rails.logger.info "Fishbowl::Connection#attach_ticket PID #{Process.pid.inspect}"
      if @ticket.nil?
        @ticket = Nokogiri::XML::Node.new('Ticket', request_builder.doc)
      end

      node = request_builder.doc.xpath('//FbiXml/*').first
      node.add_previous_sibling(@ticket)

      Rails.logger.info "Fishbowl::Connection#attach_ticket node #{node.inspect}"

      request_builder
    end

    def write(request_builder)
      Rails.logger.info "Fishbowl::Connection#write PID #{Process.pid.inspect}"
      body = request_builder.to_xml
      size = [body.size].pack("N")

      ready = IO.select(nil, [@connection], nil, @write_timeout)

      Rails.logger.info "Fishbowl::Connection#write request_builder #{request_builder.inspect}"
      Rails.logger.info "Fishbowl::Connection#write body #{body.inspect}"
      Rails.logger.info "Fishbowl::Connection#write size #{size.inspect}"
      Rails.logger.info "Fishbowl::Connection#write ready #{ready.inspect}"

      raise Errors::ConnectionTimeout if !ready

      @connection.write(size)
      @connection.write(body)
    end

    def get_response(request)
      ready = IO.select([@connection], nil, nil, @read_timeout)

      Rails.logger.info "Fishbowl::Connection#get_response PID #{Process.pid.inspect}"
      Rails.logger.info "Fishbowl::Connection#get_response request #{request.inspect}"
      Rails.logger.info "Fishbowl::Connection#get_response ready #{ready.inspect}"

      raise Errors::ConnectionTimeout if !ready

      length = @connection.read(4).unpack('N').join('').to_i
      response_doc = Nokogiri::XML.parse(@connection.read(length))
      @last_response = response_doc

      _, _, @ticket, response = request.parse_response(response_doc)

      Rails.logger.info "Fishbowl::Connection#get_response length #{length.inspect}"
      Rails.logger.info "Fishbowl::Connection#get_response response_doc #{response_doc.inspect}"
      Rails.logger.info "Fishbowl::Connection#get_response last_response #{@last_response.inspect}"
      Rails.logger.info "Fishbowl::Connection#get_response ticket #{@ticket.inspect}"

      response
    end

  end
end
