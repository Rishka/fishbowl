require 'nokogiri'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class TagQuery < BaseRequest

    attr_accessor :tag_id, :tag_num, :location_id

    def compose
      validate
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.TagQueryRq {
            xml.TagID @tag_id unless @tag_id.nil?
            xml.TagNum @tag_num unless @tag_num.nil?
            xml.LocationID @location_id unless @location_id.nil?
          }
        }
      end)
    end

  protected

    def distill(response)
      response_doc.xpath('//Tag').map { |n| Fishbowl::Objects::Tag.from_xml(n) }
    end

  end

end
