require 'roxml'
require 'fishbowl/objects/location'
require 'fishbowl/objects/uom'
require 'fishbowl/objects/part'
require 'fishbowl/objects/tag'
require 'fishbowl/objects/tracking'

module Fishbowl::Objects

  class PickOrder
    include ROXML

    xml_accessor :order_type, :from => 'OrderType'
    xml_accessor :order_type_id, :from => 'OrderTypeID', :as => Integer
    xml_accessor :order_num, :from => 'OrderNum'
    xml_accessor :order_id, :from => 'OrderID', :as => Integer
    xml_accessor :order_to, :from => 'OrderTo'
    xml_accessor :note, :from => 'Note'
  end

  class DestinationTag
    include ROXML

    xml_accessor :tag, :from => 'Tag', :as => Tag
  end

  class PickItem
    include ROXML

    xml_accessor :db_id, :from => 'PickItemID', :as => Integer
    xml_accessor :status, :from => 'Status'
    xml_accessor :part, :from => 'Part', :as => Part
    xml_accessor :tag, :from => 'Tag', :as => Tag
    xml_accessor :quantity, :from => 'Quantity'
    xml_accessor :uom, :from => 'UOM', :as => UOM
    xml_accessor :tracking, :from => 'Tracking', :as => Tracking
    xml_accessor :destination_tag, :from => 'DestinationTag', :as => DestinationTag
    xml_accessor :order_type, :from => 'OrderType'
    xml_accessor :order_type_id, :from => 'OrderTypeID', :as => Integer
    xml_accessor :order_num, :from => 'OrderNum'
    xml_accessor :order_id, :from => 'OrderID', :as => Integer
    xml_accessor :order_item_id, :from => 'OrderItemID', :as => Integer
    xml_accessor :slot_number, :from => 'SlotNumber'
    xml_accessor :note, :from => 'Note'
    xml_accessor :location, :from => 'Location', :as => Location
    xml_accessor :pick_item_type, :from => 'PickItemType'
  end

  class Pick
    include ROXML

    xml_name 'Pick'
    xml_accessor :db_id, :from => 'PickID', :as => Integer
    xml_accessor :number, :from => 'Number'
    xml_accessor :type, :from => 'Type'
    xml_accessor :type_id, :from => 'TypeID', :as => Integer
    xml_accessor :status, :from => 'Status'
    xml_accessor :status_id, :from => 'StatusID', :as => Integer
    xml_accessor :priority, :from => 'Priority'
    xml_accessor :priority_id, :from => 'PriorityID', :as => Integer
    xml_accessor :location_group_id, :from => 'LocationGroupID', :as => Integer
    xml_accessor :date_last_modified, :from => 'DateLastModified'
    xml_accessor :date_scheduled, :from => 'DateScheduled'
    xml_accessor :date_created, :from => 'DateCreated'
    xml_accessor :date_started, :from => 'DateStarted'
    xml_accessor :date_finished, :from => 'DateFinished'
    xml_accessor :user_name, :from => 'UserName'
    xml_accessor :pick_orders, :from => 'PickOrder', :as => [PickOrder], :in => 'PickOrders'
    xml_accessor :pick_items, :from => 'PickItem', :as => [PickItem], :in => 'PickItems'
  end

end
