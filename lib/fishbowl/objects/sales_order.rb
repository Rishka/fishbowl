require 'roxml'
require 'fishbowl/objects/custom_field'
require 'fishbowl/objects/memo'

module Fishbowl::Objects

  class CustomerAddress
    include ROXML

    xml_name 'CustomerAddress'
    xml_accessor :name, :from => 'Name'
    xml_accessor :address_field, :from => 'AddressField'
    xml_accessor :city, :from => 'City'
    xml_accessor :zip, :from => 'Zip'
    xml_accessor :country, :from => 'Country'
    xml_accessor :state, :from => 'State'
  end

  class BillTo < CustomerAddress
    xml_name 'BillTo'
  end

  class Ship < CustomerAddress
    xml_name 'Ship'
  end

  class SalesOrderItem
    include ROXML

    xml_name 'SalesOrderItem'
    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :product_number, :from => 'ProductNumber'
    xml_accessor :so_id, :from => 'SOID', :as => Integer
    xml_accessor :description, :from => 'Description'
    xml_accessor :taxable?, :from => 'Taxable'
    xml_accessor :quantity, :from => 'Quantity', :as => Integer
    xml_accessor :product_price, :from => 'ProductPrice', :as => Float
    xml_accessor :total_price, :from => 'TotalPrice', :as => Float
    xml_accessor :uom_code, :from => 'UOMCode'
    xml_accessor :item_type, :from => 'ItemType', :as => Integer
    xml_accessor :status, :from => 'Status', :as => Integer
    xml_accessor :quickbooks_class_name, :from => 'QuickBooksClassName'
    xml_accessor :new_item?, :from => 'NewItemFlag'
    xml_accessor :line_number, :from => 'LineNumber', :as => Integer
    xml_accessor :kit_item?, :from => 'KitItemFlag'
    xml_accessor :adjustment_amount, :from => 'AdjustmentAmount', :as => Float
    xml_accessor :adjust_percentage, :from => 'AdjustPercentage', :as => Float
    xml_accessor :customer_part_num, :from => 'CustomerPartNum'
    xml_accessor :date_last_fulfillment, :from => 'DateLastFulfillment'
    xml_accessor :date_last_modified, :from => 'DateLastModified'
    xml_accessor :date_scheduled_fulfillment, :from => 'DateScheduledFulfillment'
    xml_accessor :exchange_so_line_item, :from => 'ExchangeSOLineItem', :as => Integer
    xml_accessor :item_adjust_id, :from => 'ItemAdjustID', :as => Integer
    xml_accessor :qty_fulfilled, :from => 'QtyFulfilled', :as => Integer
    xml_accessor :qty_picked, :from => 'QtyPicked', :as => Integer
    xml_accessor :revision_level, :from => 'RevisionLevel'
    xml_accessor :total_cost, :from => 'TotalCost', :as => Float
    xml_accessor :tax_id, :from => 'TaxID', :as => Integer
    xml_accessor :tax_rate, :from => 'TaxRate', :as => Float
  end

  class SalesOrder
    include ROXML

    xml_name 'SalesOrder'
    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :note, :from => 'Note'
    xml_accessor :total_price, :from => 'TotalPrice', :as => Float
    xml_accessor :total_tax, :from => 'TotalTax', :as => Float
    xml_accessor :payment_total, :from => 'PaymentTotal', :as => Float
    xml_accessor :item_total, :from => 'ItemTotal', :as => Float
    xml_accessor :salesman, :from => 'Salesman'
    xml_accessor :number, :from => 'Number'
    xml_accessor :status, :from => 'Status', :as => Integer
    xml_accessor :carrier, :from => 'Carrier'
    xml_accessor :first_ship_date, :from => 'FirstShipDate'
    xml_accessor :created_date, :from => 'CreatedDate'
    xml_accessor :issued_date, :from => 'IssuedDate'
    xml_accessor :tax_rate_percentage, :from => 'TaxRatePercentage', :as => Float
    xml_accessor :tax_rate_name, :from => 'TaxRateName'
    xml_accessor :shipping_cost, :from => 'ShippingCost', :as => Float
    xml_accessor :shipping_terms, :from => 'ShippingTerms'
    xml_accessor :payment_terms, :from => 'PaymentTerms'
    xml_accessor :customer_contact, :from => 'CustomerContact'
    xml_accessor :customer_name, :from => 'CustomerName'
    xml_accessor :customer_id, :from => 'CustomerID', :as => Integer
    xml_accessor :fob, :from => 'FOB'
    xml_accessor :quickbooks_class_name, :from => 'QuickBooksClassName'
    xml_accessor :location_group, :from => 'LocationGroup'
    xml_accessor :bill_to, :from => 'BillTo', :as => BillTo
    xml_accessor :ship, :from => 'Ship', :as => Ship
    xml_accessor :issue?, :from => 'IssueFlag'
    xml_accessor :vendor_po, :from => 'VendorPO'
    xml_accessor :customer_po, :from => 'CustomerPO'
    xml_accessor :ups_service_id, :from => 'UPSServiceID', :as => Integer
    xml_accessor :total_includes_tax?, :from => 'TotalIncludesTax'
    xml_accessor :type_id, :from => 'TypeID', :as => Integer
    xml_accessor :url, :from => 'URL'
    xml_accessor :cost, :from => 'Cost', :as => Float
    xml_accessor :date_completed, :from => 'DateCompleted'
    xml_accessor :date_last_modified, :from => 'DateLastModified'
    xml_accessor :date_revision, :from => 'DateRevision'
    xml_accessor :register_id, :from => 'RegisterID', :as => Integer
    xml_accessor :residential?, :from => 'ResidentialFlag'
    xml_accessor :salesman_initials, :from => 'SalesmanInitials'
    xml_accessor :priority_id, :from => 'PriorityId', :as => Integer
    xml_accessor :custom_fields, :from => 'CustomField', :as => [CustomField], :in => 'CustomFields'
    xml_accessor :memos, :from => 'Memo', :as => [Memo], :in => 'Memos'
    xml_accessor :items, :from => 'SalesOrderItem', :as => [SalesOrderItem], :in => 'Items'
  end

end
