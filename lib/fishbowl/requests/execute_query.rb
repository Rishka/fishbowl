require 'nokogiri'
require 'csv'
require 'ostruct'
require 'fishbowl/requests/base_request'

module Fishbowl::Requests

  class ExecuteQuery < BaseRequest
    attr_accessor :name, :query

    def compose
      envelope(Nokogiri::XML::Builder.new do |xml|
        xml.request {
          xml.ExecuteQueryRq {
            xml.Name @name unless @name.nil?
            xml.Query @query unless @query.nil?
          }
        }
      end)
    end

  protected

    def distill(response_doc)
      rows = response_doc.xpath('//Row')
      headers = CSV.parse_line(rows.shift.content).map(&:downcase)

      hashes = []
      rows.each do |row|
        hashes << OpenStruct.new(CSV.parse_line(row.content.encode('UTF-8', {invalid: :replace, undef: :replace, replace: ''}), headers: headers).to_hash)
      end

      hashes
    end

  end

end
