require 'roxml'
require 'fishbowl/objects/location'
require 'fishbowl/objects/tracking'

module Fishbowl::Objects
  class Tag
    include ROXML
    xml_name 'Tag'
    xml_accessor :order_type, :from => 'TagID', :as => Integer
    xml_accessor :order_type, :from => 'Num'
    xml_accessor :order_type, :from => 'PartNum'
    xml_accessor :order_type, :from => 'Location', :as => Location
    xml_accessor :order_type, :from => 'Quantity'
    xml_accessor :order_type, :from => 'QuantityCommitted'
    xml_accessor :order_type, :from => 'WONum'
    xml_accessor :order_type, :from => 'DateCreated'
    xml_accessor :order_type, :from => 'Tracking', :as => Location
    xml_accessor :order_type, :from => 'TypeID', :as => Integer
    xml_accessor :order_type, :from => 'AccountID', :as => Integer
  end
end
