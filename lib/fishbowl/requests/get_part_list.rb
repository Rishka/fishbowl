require 'nokogiri'
require 'fishbowl/requests/base_request'
require 'fishbowl/objects/part'

module Fishbowl::Requests

  class GetPartList < BaseRequest
    attr_accessor :part_num, :part_desc, :part_details, :part_upc
    attr_accessor :part_type, :abc_code, :vendor_name, :vendor_num
    attr_accessor :product_num, :product_desc, :active, :show_active
    attr_accessor :show_inactive, :has_bom, :configurable

    def compose
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.GetPartListRq {
            xml.PartNum unless @part_num.nil?
            xml.PartDesc unless @part_desc.nil?
            xml.PartDetails unless @part_details.nil?
            xml.PartUPC unless @part_upc.nil?
            xml.PartType unless @part_type.nil?
            xml.ABCCode unless @abc_code.nil?
            xml.VendorName unless @vendor_name.nil?
            xml.VendorNum unless @vendor_num.nil?
            xml.ProductNum unless @product_num.nil?
            xml.ProductDesc unless @product_desc.nil?
            xml.Active unless @active.nil?
            xml.ShowActive unless @show_active.nil?
            xml.ShowInactive unless @show_inactive.nil?
            xml.HasBOM unless @has_bom.nil?
            xml.Configurable unless @configurable.nil?
          }
        }
      end)
    end

  protected

    def distill(response_doc)
      response_doc.xpath('//LightPart').map { |n| Fishbowl::Objects::LightPart.from_xml(n) }
    end

  end

end
