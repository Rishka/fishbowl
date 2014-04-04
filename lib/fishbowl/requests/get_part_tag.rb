require 'nokogiri'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class GetPartTag < BaseRequest
    attr_accessor :part_num, :location_group

    def compose
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.PartQueryRq {
            xml.PartNum @part_num
            xml.LocationGroup @location_group
          }
        }
      end)
    end

  protected

    def validate
      %w{part_num location_group}.each do |field|
        raise "Missing field: #{field}" if field.nil?
      end
    end

    def distill(response_doc)
      xml = response_doc.at_xpath('//Tag')
      Fishbowl::Objects::Part.from_xml(xml) if xml
    end

  end

end
