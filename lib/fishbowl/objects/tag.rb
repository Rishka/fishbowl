require 'roxml'
require 'fishbowl/objects/location'
require 'fishbowl/objects/tracking'

module Fishbowl::Objects
  class Tag
    include ROXML
    xml_name 'Tag'
    xml_accessor :db_id, :from => 'TagID', :as => Integer
    xml_accessor :num, :from => 'Num'
    xml_accessor :part_num, :from => 'PartNum'
    xml_accessor :location, :from => 'Location', :as => Location
    xml_accessor :quantity, :from => 'Quantity'
    xml_accessor :quantity_commited, :from => 'QuantityCommitted'
    xml_accessor :wo_num, :from => 'WONum'
    xml_accessor :date_created, :from => 'DateCreated'
    xml_accessor :tracking, :from => 'Tracking', :as => Tracking
    xml_accessor :type_id, :from => 'TypeID', :as => Integer
    xml_accessor :account_id, :from => 'AccountID', :as => Integer
  end
end
