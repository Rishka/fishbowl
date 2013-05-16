require 'nokogiri'
require 'fishbowl/requests/base_request'
require 'fishbowl/objects/sales_order'

module Fishbowl::Requests

  class AddSalesOrderItem < BaseRequest

    attr_accessor :order_number, :sales_order, :sales_order_item

    def compose
      validate
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.AddSOItemRq {
            @sales_order.nil? ? (xml.OrderNum @order_number) : (xml.SalesOrder @sales_order)
            xml << @sales_order_item.to_xml
          }
        }
      end)
    end

  protected

    def validate
      raise ArgumentError, 'Must provide one of order_number, sales_order' if @order_number.nil? && @sales_order.nil?
      if @sales_order && !@sales_order.is_a?(Fishbowl::Objects::SalesOrder)
        raise ArgumentError, 'sales_order must be a SalesOrder object'
      end
      if !(@sales_order_item || @sales_order_item.is_a?(Fishbowl::Objects::SalesOrderItem))
        raise ArgumentError, 'sales_order_item must be a SalesOrderItem object'
      end
    end

    def distill(response)
    end

  end

end
