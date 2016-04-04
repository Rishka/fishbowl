require 'nokogiri'
require 'fishbowl/objects/sales_order'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class GetSalesOrderList < BaseRequest

    attr_accessor :so_num, :product_num, :date_last_modified_begin, :date_last_modified_end

    def compose
      validate
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.GetSOListRq {
            xml.SONum @so_num unless @so_num.nil?
            xml.ProductNum @product_num unless @product_num.nil?
            xml.DateLastModifiedBegin @date_last_modified_begin unless @date_last_modified_begin.nil?
            xml.DateLastModifiedEnd @date_last_modified_end unless @date_last_modified_end.nil?
          }
        }
      end)
    end

  protected

    def validate
    end

    def distill(response_doc)
      response_doc.xpath('//SalesOrder').map { |n| Fishbowl::Objects::SalesOrder.from_xml(n) }
    end

  end

end
