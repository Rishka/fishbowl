require 'roxml'

module Fishbowl::Objects

  class SerialNum
    include ROXML

    xml_accessor :serial_id, :from => 'SerialID'
    xml_accessor :serial_num_id, :from => 'SerialNumID'
    xml_accessor :number, :from => 'Number'
  end

  class SerialNumList
    include ROXML

    xml_accessor :serial_num, :from => 'SerialNum', :as => SerialNum
  end

  class SerialBox
    include ROXML

    xml_accessor :serial_id, :from => 'SerialID'
    xml_accessor :tag_id, :from => 'TagID'
    xml_accessor :committed, :from => 'Committed'
    xml_accessor :serial_num_list, :from => 'SerialNumList', :as => SerialNumList
  end

  class SerialBoxList
    include ROXML

    xml_accessor :serial_boxes, :from => 'SerialBox', :as => [SerialBox]
  end

  class PartTracking
    include ROXML

    xml_accessor :part_tracking_id, :from => 'PartTrackingID', :as => Integer
    xml_accessor :name, :from => 'Name'
    xml_accessor :abbr, :from => 'Abbr'
    xml_accessor :description, :from => 'Description'
    xml_accessor :sort_order, :from => 'SortOrder', :as => Integer
    xml_accessor :tracking_type_id, :from => 'TrackingTypeID', :as => Integer
    xml_accessor :active?, :from => 'Active'
    xml_accessor :primary?, :from => 'Primary'
  end

  class TrackingItem
    include ROXML

    xml_accessor :part_tracking, :from => 'PartTracking', :as => [PartTracking]
    xml_accessor :tracking_value, :from => 'TrackingValue'
    xml_accessor :serial_box_list, :from => 'SerialBoxList', :as => SerialBoxList
  end

  class Tracking
    include ROXML

    xml_name 'Tracking'
    xml_accessor :item, :from => 'TrackingItem', :as => TrackingItem
  end

  class PartTrackingList
    include ROXML

    xml_name 'PartTrackingList'
    xml_accessor :part_tracking, :from => 'PartTracking', :as => [PartTracking]
  end

end
