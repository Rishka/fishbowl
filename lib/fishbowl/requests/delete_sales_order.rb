require 'nokogiri'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class DeleteSalesOrder < BaseRequest
    attr_accessor :so_number

    def compose
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.DeleteSORq {
            xml.SONumber @so_number
          }
        }
      end)
    end

  protected

    def validate
      raise ArgumentError, 'Must provide so_number' if @so_number.nil?
    end

    def distill(response_doc)
    end

  end

end
