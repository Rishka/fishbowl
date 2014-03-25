require 'roxml'

module Fishbowl::Objects

  class LocationGroup
    include ROXML

    xml_name 'LocationGroup'
    xml_accessor :location_group_id, :from => 'LocationGroupID', :as => Integer
    xml_accessor :location_group_name, :from => 'LocationGroupName'
    xml_accessor :users_default_lg?, :from => 'UsersDefaultLG'
  end

  class Location
    include ROXML

    xml_name 'Location'
    xml_accessor :location_id, :from => 'LocationID', :as => Integer
    xml_accessor :type_id, :from => 'TypeID', :as => Integer
    xml_accessor :parent_id, :from => 'ParentID', :as => Integer
    xml_accessor :name, :from => 'Name'
    xml_accessor :description, :from => 'Description'
    xml_accessor :counted_as_available?, :from => 'CountedAsAvailable'
    xml_accessor :default?, :from => 'Default'
    xml_accessor :active?, :from => 'Active'
    xml_accessor :pickable?, :from => 'Pickable'
    xml_accessor :receivable?, :from => 'Receivable'
    xml_accessor :location_group_id, :from => 'LocationGroupID', :as => Integer
    xml_accessor :location_group_name, :from => 'LocationGroupName'
    xml_accessor :enforce_tracking?, :from => 'EnforceTracking'
    xml_accessor :sort_order, :from => 'SortOrder', :as => Integer
    xml_accessor :tag_id, :from => 'TagID', :as => Integer
    xml_accessor :tag_number, :from => 'TagNumber', :as => Integer
  end

end
