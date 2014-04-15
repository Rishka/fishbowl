require 'nokogiri'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class AddInventory < BaseRequest

    attr_accessor :part_number, :quantity, :uom_id,
                  :cost, :location_tag_number, :tag_number,
                  :note, :tracking

    def compose
      validate
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.AddInventoryRq {
            xml.PartNum @part_number
            xml.Quantity @quantity
            xml.UOMID @uom_id
            xml.Cost @cost
            xml.Note @note unless @note.nil?
            xml << @tracking.to_xml.to_xml unless @tracking.nil?
            xml.LocationTagNum @location_tag_number
            xml.TagNum @tag_number
          }
        }
      end)
    end

  protected

    def validate
      required_fields = %w{part_number quantity uom_id cost location_tag_number tag_number}
      required_fields.each do |field|
        raise ArgumentError, "Missing field: #{field}" if instance_variable_get("@#{field}").nil?
      end

      if !@tracking.nil? && !@tracking.is_a?(Fishbowl::Objects::Tracking)
        raise ArgumentError, "Tracking field must contain an object"
      end
    end

    def distill(response)
    end

  end

end
