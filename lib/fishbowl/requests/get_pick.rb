require 'nokogiri'
require 'fishbowl/requests/base_request'
require 'fishbowl/objects/pick'

module Fishbowl::Requests

  class GetPick < BaseRequest

   attr_accessor :pick_num

    def compose
      validate
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.GetPickRq {
            xml.PickNum @pick_num
          }
        }
      end)
    end

  protected

    def validate
      raise 'Missing field: pick_num' if @pick_num.nil?
    end

    def distill(response_doc)
      xml = response_doc.at_xpath('//GetPickRs')
      Fishbowl::Objects::Pick.from_xml(xml) if xml
    end

  end

end
