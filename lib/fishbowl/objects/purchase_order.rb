require 'roxml'
require 'fishbowl/objects/address'

module Fishbowl::Objects

  class PurchaseOrderItem
    include ROXML

    xml_name "PurchaseOrderItem"
    xml_accessor :part_number, :from => 'PartNumber'
    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :description, :from => 'Description'
    xml_accessor :quantity, :from  => 'Quantity', :as => Integer
    xml_accessor :quantity_fulfilled, :from => 'QuantityFulfilled', :as => Integer
    xml_accessor :quantity_picked, :from => 'QuantityPicked', :as => Integer
    xml_accessor :uom_code, :from => 'UOMCode'
    xml_accessor :vendor_part_num, :from => 'VendorPartNum'
    xml_accessor :item_type, :from => 'ItemType', :as => Integer
    xml_accessor :status, :from => 'Status', :as => Integer
    xml_accessor :note, :from => 'Note'
    xml_accessor :unit_cost, :from => 'UnitCost', :as => Float
    xml_accessor :quick_books_class_name, :from => 'QuickBooksClassName'
    xml_accessor :revision_level, :from => 'RevisionLevel'
    xml_accessor :scheduled_fulfillment_date, :from => 'ScheduledFulfillmentDate'
  end

  class PurchaseOrder
    include ROXML

    xml_name "PurchaseOrder"
    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :note, :from => 'Note'
    xml_accessor :created_date, :from => 'CreatedDate'
    xml_accessor :first_ship_date, :from => 'FirstShipDate'
    xml_accessor :number, :from => 'Number'
    xml_accessor :status, :from => 'Status', :as => Integer
    xml_accessor :buyer, :from => 'Buyer'
    xml_accessor :remit_to, :from => 'RemitTo', :as => RemitTo
    xml_accessor :ship, :from => 'Ship', :as => Ship
    xml_accessor :deliver_to, :from => 'DeliverTo'
    xml_accessor :shipping_cost, :from => 'ShippingCost', :as => Float
    xml_accessor :shipping_terms, :from => 'ShippingTerms', :as => Integer
    xml_accessor :payment_terms, :from => 'PaymentTerms'
    xml_accessor :fob, :from => 'FOB'
    xml_accessor :vendor_contact, :from => 'VendorContact'
    xml_accessor :vendor_name, :from => 'VendorName'
    xml_accessor :vendor_so_num, :from => 'VendorSONum'
    xml_accessor :quick_books_class_name, :from => 'QuickBooksClassName'
    xml_accessor :location_group, :from => 'LocationGroup'
    xml_accessor :carrier, :from => 'Carrier'
    xml_accessor :currency_rate, :from => 'CurrencyRate', :as => Float
    xml_accessor :currency_name, :from => 'CurrencyName'
    xml_accessor :cost_is_home_currency?, :from => 'CostIsHomeCurrency'
    xml_accessor :purchase_order_items, :from => 'PurchaseOrderItem', :as => [PurchaseOrderItem], :in => 'Items'

  end
end
