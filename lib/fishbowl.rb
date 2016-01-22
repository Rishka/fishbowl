
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

    attr_accessor :host, :port, :username, :password, :encoding
    attr_reader :last_request, :last_response

    @connection = nil
    @ticket = nil

    def initialize(options = {})
      raise Errors::MissingHost if options[:host].nil?

      @host = options[:host]
      @port = options[:port] || 28192

      @connect_timeout = options[:connect_timeout] || 5.0
      @read_timeout = options[:read_timeout] || 30.0
      @write_timeout = options[:write_timeout] || 5.0
      @encoding = "UTF-8"
    end

    def connect
      @connection = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
      sockaddr = Socket.sockaddr_in(@port, @host)

      begin
        @connection.connect_nonblock(sockaddr)
      rescue Errno::EINPROGRESS
        if IO.select(nil, [@connection], nil, @connect_timeout)
          retry
        else
          @connection.close
          @connection = nil
          raise Errors::ConnectionTimeout
        end
      rescue Errno::EISCONN
        # connection completed successfully
      end

      self
    end

    def connected?
      !!@connection
    end

    def login(username, password)
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
        send_request(login_request)
      rescue
        clear_ticket
        raise
      end

      self
    end

    def send_request(request)
      raise Errors::ConnectionNotEstablished unless connected?

      request_builder = request.compose
      attach_ticket(request_builder)

      @last_request = request_builder.doc
      @last_response = nil

      write(request_builder)
      get_response(request)
    end

    def close
      @connection.close if @connection
      @connection = nil
      clear_ticket
      self
    end

    def has_ticket?
      !!@ticket
    end

    def clear_ticket
      @ticket = nil
    end

    # Create utility proxies to requests, eg., will add method "add_inventory"
    # that builds and sends a Fishbowl::Requests::AddInventory
    Requests.constants.each do |c|
      module_constant = Requests.const_get(c)
      method_name = c.to_s.underscore.to_sym
      if module_constant.is_a?(Class) && !self.method_defined?(method_name)
        define_method method_name do |attributes = {}|
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
      if @ticket.nil?
        @ticket = Nokogiri::XML::Node.new('Ticket', request_builder.doc)
      end

      node = request_builder.doc.xpath('//FbiXml/*').first
      node.add_previous_sibling(@ticket)

      request_builder
    end

    def write(request_builder)
      body = request_builder.to_xml
      size = [body.size].pack("N")

      ready = IO.select(nil, [@connection], nil, @write_timeout)
      raise Errors::ConnectionTimeout if !ready

      @connection.write(size)
      @connection.write(body)
    end

    def get_response(request)
      ready = IO.select([@connection], nil, nil, @read_timeout)
      raise Errors::ConnectionTimeout if !ready

      length = @connection.read(4).unpack('N').join('').to_i
      response_doc = Nokogiri::XML.parse(@connection.read(length), nil, @encoding)
      @last_response = response_doc

      _, _, @ticket, response = request.parse_response(response_doc)

      response
    end

  end
end
