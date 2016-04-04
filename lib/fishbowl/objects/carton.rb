require 'roxml'
require 'fishbowl/objects/tracking'
require 'fishbowl/objects/uom'
require 'fishbowl/objects/tracking'

module Fishbowl::Objects

  class ShippingItem
    include ROXML

    xml_accessor :ship_item_id, :from => 'ShipItemID', :as => Integer
    xml_accessor :product_number, :from => 'ProductNumber'
    xml_accessor :product_description, :from => 'ProductDescription'
    xml_accessor :qty_shipped, :from => 'QuantityShipped', :as => Integer
    xml_accessor :uom, :from => 'UOM', :as => UOM
    xml_accessor :cost, :from => 'Cost', :as => Float
    xml_accessor :sku, :from => 'SKU'
    xml_accessor :upc, :from => 'UPC'
    xml_accessor :order_line_item, :from => 'OrderLineItem', :as => Integer
    xml_accessor :carton_name, :from => 'CartonName'
    xml_accessor :carton_id, :from => 'CartonID', :as => Integer
    xml_accessor :tag_num, :from => 'TagNum', :as => Integer
    xml_accessor :weight, :from => 'Weight', :as => Float
    xml_accessor :weight_uom, :from => 'UOM', :as => UOM, :in => 'WeightUOM'
    xml_accessor :display_weight, :from => 'DisplayWeight', :as => Float
    xml_accessor :display_weight_uom, :from => 'UOM', :as => UOM, :in => 'DisplayWeightUOM'
    xml_accessor :tracking, :from => 'Tracking', :as => Tracking
  end

  class Carton
    include ROXML

    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :ship_id, :from => 'ShipID', :as => Integer
    xml_accessor :carton_num, :from => 'CartonNum', :as => Integer
    xml_accessor :tracking_num, :from => 'TrackingNum'
    xml_accessor :freight_weight, :from => 'FreightWeight', :as => Float
    xml_accessor :freight_amount, :from => 'FreightAmount', :as => Float
    xml_accessor :shipping_items, :from => 'ShippingItem', :as => [ShippingItem], :in => 'ShippingItems'
  end

end
