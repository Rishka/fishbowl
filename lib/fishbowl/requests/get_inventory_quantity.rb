require 'nokogiri'
require 'date'
require 'fishbowl/objects/inventory_quantity'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class GetInventoryQuantity < BaseRequest

    attr_accessor :part_number, :last_modified_from, :last_modified_to, :light_list

    def compose
      validate
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.InvQtyRq {
            xml.PartNum @part_number
            xml.LastModifiedFrom @last_modified_from unless @last_modified_from.nil?
            xml.LastModifiedTo @last_modified_to unless @last_modified_to.nil?
          }
        }
      end)
    end

  protected

    def validate
      raise 'Missing field: part_number' if @part_number.nil?
    end

    def distill(response_doc)
      if @light_list == true
        response_doc.xpath('//InvQty').map { |n| Fishbowl::Objects::LightInventoryQuantity.from_xml(n) }
      else
        response_doc.xpath('//InvQty').map { |n| Fishbowl::Objects::InventoryQuantity.from_xml(n) }
      end
    end

  end

end
