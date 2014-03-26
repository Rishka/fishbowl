require 'nokogiri'
require 'fishbowl/objects/purchase_order'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class POSave < BaseRequest

    attr_accessor :purchase_order

    def compose
      validate
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.POSaveRq {
            xml << @purchase_order.to_xml.to_xml
          }
        }
      end)
    end

  protected

    def validate
      raise 'Missing field: purchase_order' if @purchase_order.nil?
      raise 'purchase_order must be a PurchaseOrder object' if !@purchase_order.is_a?(Fishbowl::Objects::PurchaseOrder)
    end

    def distill(response_doc)
      xml = response_doc.at_xpath('//PurchaseOrder')
      Fishbowl::Objects::PurchaseOrder.from_xml(xml) if xml
    end

  end

end
