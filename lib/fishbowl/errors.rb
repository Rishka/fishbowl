module Fishbowl::Errors

  class FbError < RuntimeError
    attr_reader :code
    def initialize code
      @code = code
    end
  end

  class StatusError < FbError; end;
  class ServerError < FbError; end;

  {
    RuntimeError => ['ConnectionNotEstablished', 'ConnectionTimeout'],
    ArgumentError => ['Host', 'Username', 'Password'].map { |p| "Missing#{p}" }
  }.each do |base, list|
    list.each do |name|
      self.const_set(name, Class.new(base) do
        def initialize(msg = nil)
          super(msg || self.class.name.demodulize.titleize.capitalize)
        end
      end)
    end
  end

  STATUS_MAP = {
    1000 => 'Success!',
    1001 => 'Unknown message received',
    1002 => 'Connection to Fishbowl server was lost',
    1003 => 'Some requests had errors',
    1004 => 'There was an error with the database',
    1009 => 'Fishbowl server has been shut down',
    1010 => 'You have been logged off the server by an administrator',
    1011 => 'Not found',
    1012 => 'General error',
    1013 => 'Dependencies need to be deleted',
    1100 => 'Unknown login error occurred',
    1109 => 'This integrated application registration key is already in use',
    1110 => 'A new integrated application has been added to Fishbowl; please contact the Fishbowl administrator to approve this integrated application',
    1111 => 'This integrated application registration key does not match',
    1112 => 'This integrated application has not been approved by the Fishbowl administrator',
    1120 => 'Invalid username or password',
    1130 => 'Invalid ticket passed to Fishbowl server',
    1131 => 'Invalid ticket key passed to Fishbowl server',
    1140 => 'Initialization token is not correct type',
    1150 => 'Request was invalid',
    1161 => 'Response was invalid',
    1162 => 'The login limit has been reached for the server\'s key',
    1200 => 'Custom field is invalid',
    1300 => 'Was not able to find the memo',
    1301 => 'The memo was invalid',
    1400 => 'Was not able to find the order history',
    1401 => 'The order history was invalid',
    1500 => 'The import was not properly formed',
    1501 => 'That import type is not supported',
    1502 => 'File not found',
    1503 => 'That export type is not supported',
    1504 => 'Unable to write to file',
    1505 => 'The import data was of the wrong type',
    1600 => 'Unable to load the user',
    1601 => 'Unable to find the user',
    2000 => 'Was not able to find the part',
    2001 => 'The part was invalid',
    2002 => 'Was not able to find a unique part',
    2003 => 'BOM had an error on the part',
    2100 => 'Was not able to find the product',
    2101 => 'The product was invalid',
    2102 => 'The product is not unique',
    2120 => 'The kit item was invalid',
    2121 => 'The associated product was invalid',
    2200 => 'Yield failed',
    2201 => 'Commit failed',
    2202 => 'Add initial inventory failed',
    2203 => 'Cannot adjust committed inventory',
    2204 => 'Invalid quantity',
    2205 => 'Quantity must be greater than zero',
    2206 => 'Serial number already committed',
    2207 => 'Part is not an inventory part',
    2208 => 'Not enough available quantity',
    2209 => 'Move failed',
    2210 => 'Cycle count failed',
    2300 => 'Was not able to find the tag number',
    2301 => 'The tag was invalid',
    2302 => 'The tag move failed',
    2303 => 'Was not able to save tag number',
    2304 => 'Not enough available inventory in tag number',
    2305 => 'Tag number is a location',
    2400 => 'Invalid UOM',
    2401 => 'UOM not found',
    2402 => 'Integer UOM cannot have non-integer quantity',
    2403 => 'The UOM is not compatible with the part\'s base UOM',
    2404 => 'Cannot convert to the requested UOM',
    2405 => 'Cannot convert to the requested UOM',
    2406 => 'The quantity must be a whole number',
    2407 => 'The UOM conversion for the quantity must be a whole number',
    2500 => 'The tracking is not valid',
    2501 => 'Part tracking not found',
    2502 => 'The part tracking name is required',
    2503 => 'The part tracking name is already in use',
    2504 => 'The part tracking abbreviation is required',
    2505 => 'The part tracking abbreviation is already in use',
    2506 => 'The part tracking is in use or was used and cannot be deleted',
    2510 => 'Serial number is missing',
    2511 => 'Serial number is null',
    2512 => 'Duplicate serial number',
    2513 => 'The serial number is not valid',
    2514 => 'Tracking is not equal',
    2515 => 'The tracking was not found in the location or is committed to another order',
    2600 => 'Location not found',
    2601 => 'Invalid location',
    2602 => 'Location group not found',
    2603 => 'Default customer not specified for location',
    2604 => 'Default vendor not specified for location',
    2605 => 'Default location for part not found',
    2606 => 'Not a pickable location',
    2607 => 'Not a receivable location',
    2700 => 'Location group not found',
    2701 => 'Invalid location group',
    2702 => 'User does not have access to location group',
    3000 => 'Customer not found',
    3001 => 'Customer is invalid',
    3002 => 'Customer must have a default main office address',
    3100 => 'Vendor not found',
    3101 => 'Vendor is invalid',
    3300 => 'Address not found',
    3301 => 'Invalid address',
    4000 => 'There was an error loading PO',
    4001 => 'Unknown status',
    4002 => 'Unknown carrier',
    4003 => 'Unknown QuickBooks class',
    4004 => 'PO does not have a PO number; please turn on the auto-assign PO number option in the purchase order module options',
    4005 => 'Duplicate order number',
    4006 => 'Cannot create PO with configurable parts',
    4007 => 'The parts were not added to the purchase order; they have no default vendor'
  }

  def self.confirm_success_or_raise(code, message)
    message = STATUS_MAP[code.to_i] if message.nil?
    case code.to_i
    when 1000
      true
    when 1001..1999
      raise ServerError.new(code.to_i), message
    else
      raise StatusError.new(code.to_i), message
    end
  end
end
