require 'roxml'
require 'fishbowl/objects/uom'

module Fishbowl::Objects
  class Part
    include ROXML

    xml_accessor :part_id, :from => 'PartID', :as => Integer
    xml_accessor :part_class_id, :from => 'PartClassID', :as => Integer
    xml_accessor :type_id, :from => 'TypeID', :as => Integer
    xml_accessor :uoms, :from => 'UOM', :as => [UOM]
    xml_accessor :num, :from => 'Num'
    xml_accessor :description, :from => 'Description'
    xml_accessor :details, :from => 'Details'
    xml_accessor :abc_code, :from => 'ABCCode'
    xml_accessor :standard_cost, :from => 'StandardCost'
    xml_accessor :has_bom?, :from => 'HasBOM'
    xml_accessor :configurable?, :from => 'Configurable'
    xml_accessor :active?, :from => 'ActiveFlag'
    xml_accessor :serialized?, :from => 'SerializedFlag'
    xml_accessor :tracking?, :from => 'TrackingFlag'
    xml_accessor :weight, :from => 'Weight', :as => Float
    xml_accessor :weight_uom, :from => 'WeightUOM', :as => WeightUOM
    xml_accessor :width, :from => 'Width'
    xml_accessor :height, :from => 'Height'
    xml_accessor :len, :from => 'Len'
    xml_accessor :size_uom, :from => 'SizeUOM', :as => SizeUOM
  end

  class LightPart
    include ROXML

    xml_accessor :db_id, :from => 'ID', :as => Integer
    xml_accessor :num, :from => 'Num'
    xml_accessor :description, :from => 'Description'
    xml_accessor :upc, :from => 'UPC'
    xml_accessor :uom_id, :from => 'UOMID', :as => Integer
    xml_accessor :active?, :from => 'ActiveFlag'
  end

end
