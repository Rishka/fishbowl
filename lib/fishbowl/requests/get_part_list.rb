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
            xml.PartNum @part_num unless @part_num.nil?
            xml.PartDesc @part_desc unless @part_desc.nil?
            xml.PartDetails @part_details unless @part_details.nil?
            xml.PartUPC @part_upc unless @part_upc.nil?
            xml.PartType @part_type unless @part_type.nil?
            xml.ABCCode @abc_code unless @abc_code.nil?
            xml.VendorName @vendor_name unless @vendor_name.nil?
            xml.VendorNum @vendor_num unless @vendor_num.nil?
            xml.ProductNum @product_num unless @product_num.nil?
            xml.ProductDesc @product_desc unless @product_desc.nil?
            xml.Active @active unless @active.nil?
            xml.ShowActive @show_active unless @show_active.nil?
            xml.ShowInactive @show_inactive unless @show_inactive.nil?
            xml.HasBOM @has_bom unless @has_bom.nil?
            xml.Configurable @configurable unless @configurable.nil?
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
