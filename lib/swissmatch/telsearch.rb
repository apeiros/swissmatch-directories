# encoding: utf-8



require 'swissmatch/directoryservice'
require 'swissmatch/address'
require 'uri'
require 'open-uri'
require 'nokogiri'



module SwissMatch

  # A Directory service, using tel.search.ch's API.
  # Also see http://tel.search.ch/api/help
  class TelSearch < DirectoryService
    NS      = {'t' => 'http://tel.search.ch/api/spec/result/1.0/'}
    API_URI = URI.parse('http://tel.search.ch/api')

    def initialize(key)
      @key = key
      @uri = API_URI
    end

    def search_ch_mapping(params)
      {
        :was => params.values_at(:first_name, :family_name, :last_name, :maiden_name, :phone).compact.join(' '),
        :wo  => params.values_at(:street, :street_name, :street_number, :zip_code, :city).compact.join(' '),
      }.reject { |k,v| v.empty? }
    end

    def addresses(params)
      # tel.search.ch parameters
      search_params = {'key' => @key}

      uri       = @uri.dup
      uri.query = URI.encode_www_form(search_ch_mapping(params).merge(search_params))
      feed      = Nokogiri.XML(open(uri, &:read))

      feed.css('entry').map { |entry|
        Address.new(
          nil,
          extract(entry, 't|firstname'),
          extract(entry, 't|name'),
          extract(entry, 't|maidenname'),
          extract(entry, 't|street'),
          extract(entry, 't|streetno'),
          extract(entry, 't|zip', &:to_i),
          extract(entry, 't|city'),
        )
      }
    end

  private
    def extract(node, selector)
      subnode = node.at_css(selector, NS)
      text    = subnode && subnode.text

      block_given? ? yield(text) : text
    end
  end
end
