require 'nokogiri'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class Ship < BaseRequest

    attr_accessor :ship_date, :fulfill_service, :allowed_entered, :shipping_ids, :order_nums

    def compose
      validate
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.ShipRq {
            xml.ShipDate @ship_date unless @ship_date.nil?
            xml.FulfillService @fulfill_service unless @fulfill_service.nil?
            xml.AllowEntered @allowed_entered unless @allowed_entered.nil?
            xml.ShippingIDs {
              @shipping_ids.each{|id| xml.ShippingID id}
            } unless @shipping_ids.nil?
            xml.OrderNums {
              @order_nums.each{|num| xml.OrderNum num}
            }
          }
        }
      end)
    end

  protected

    def validate
      raise 'Missing field: order_nums' if @order_nums.nil?
    end

    def distill(response_doc)
    end

  end

end
