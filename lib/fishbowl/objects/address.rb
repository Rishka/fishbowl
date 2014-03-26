require 'roxml'
require 'fishbowl/objects/sales_order'

module Fishbowl::Objects

  class State
    include ROXML

    xml_name 'State'
    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :code, :from => 'Code'
    xml_accessor :name, :from => 'Name'
    xml_accessor :country_id, :from => 'CountryID', :as => Integer
  end

  class Country
    include ROXML

    xml_name 'Country'
    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :name, :from => 'Name'
    xml_accessor :code, :from => 'Code'
  end

  class TempAccount
    include ROXML

    xml_name 'TempAccount'
    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :type, :from => 'Type', :as => Integer
  end

  class AddressInformation
    include ROXML

    xml_name 'AddressInformation'
    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :name, :from => 'Name'
    xml_accessor :data, :from => 'Data'
    xml_accessor :default?, :from => 'Default'
    xml_accessor :type, :from => 'Type'
  end

  class Address
    include ROXML

    xml_name 'Address'
    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :temp_account, :from => 'Temp-Account', :as => TempAccount
    xml_accessor :name, :from => 'Name'
    xml_accessor :attn, :from => 'Attn'
    xml_accessor :street, :from => 'Street'
    xml_accessor :city, :from => 'City'
    xml_accessor :zip, :from => 'Zip'
    xml_accessor :location_group_id, :from => 'LocationGroupID', :as => Integer
    xml_accessor :default?, :from => 'Default'
    xml_accessor :residential?, :from => 'Residential'
    xml_accessor :type, :from => 'Type'
    xml_accessor :state, :from => 'State', :as => State
    xml_accessor :country, :from => 'Country', :as => Country
    xml_accessor :address_information, :from => 'AddressInformation', :as => [AddressInformation], :in => 'AddressInformationList'
  end

  class RemitTo < CustomerAddress
    xml_name 'RemitTo'
  end

end
