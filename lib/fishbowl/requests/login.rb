require 'digest'
require 'nokogiri'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class Login < BaseRequest

    attr_accessor :username, :password, :opts

    def encoded_password
      if @opts && @opts[:no_encode]
        @password
      else
        md5 = Digest::MD5.new << @password
        md5.base64digest
      end
    end

    def compose
      ia_id = (@opts && @opts[:ia_id]) || 'fishbowl-ruby'
      ia_name = (@opts && @opts[:ia_name]) || 'Fishbowl Ruby Gem'
      ia_desc = (@opts && @opts[:ia_desc]) || ia_name

      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.LoginRq {
            xml.IAID          ia_id
            xml.IAName        ia_name
            xml.IADescription ia_desc
            xml.UserName      @username
            xml.UserPassword  encoded_password
          }
        }
      end)
    end

  protected

    def distill(response)
      id_node = response.at_xpath('//Ticket/UserID')
      name_node = response.at_xpath('//LoginRs/UserFullName')

      { :user_id => (id_node.text if id_node),
        :full_name => (name_node.text if name_node) }
    end

  end

end
