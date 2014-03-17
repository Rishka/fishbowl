require 'nokogiri'
require 'fishbowl/objects/pick'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class SavePick < BaseRequest

    attr_accessor :pick

    def compose
      validate
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.SavePickRq {
            xml << @pick.to_xml.to_xml
          }
        }
      end)
    end

  protected

    def validate
      raise 'Missing field: pick' if @pick.nil?
      raise 'pick must be a Pick object' if !@pick.is_a?(Fishbowl::Objects::Pick)
    end

    def distill(response_doc)
      xml = response_doc.at_xpath('//Pick')
      Fishbowl::Objects::Pick.from_xml(xml) if xml
    end

  end

end
