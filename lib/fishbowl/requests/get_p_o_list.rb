require 'nokogiri'
require 'fishbowl/objects/purchase_order'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

 class GetPOList < BaseRequest

   attr_accessor :location_group

   def compose
     validate
     envelope(Nokogiri::XML::Builder.new do |xml|
       xml.request {
         xml.GetPOListRq {
           xml.LocationGroup @location_group
         }
       }
     end)
   end

 protected

   def validate
     raise 'Missing field: location_group' if @location_group.nil?
   end

   def distill(response_doc)
     xml = response_doc.at_xpath('//PurchaseOrder')
     Fishbowl::Objects::PurchaseOrder.from_xml(xml) if xml
   end

 end

end
