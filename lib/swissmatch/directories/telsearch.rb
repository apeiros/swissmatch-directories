# encoding: utf-8



require 'swissmatch/directories/service'
require 'uri'
require 'open-uri'
require 'nokogiri'



module SwissMatch
  module Directories

    # A Directory service, using tel.search.ch's API.
    # Also see http://tel.search.ch/api/help
    #
    # You need an API key in order to use this library. You can get one on
    # http://admin.tel.search.ch/api/getkey
    #
    # @see SwissMatch::Directories Usage examples
    class TelSearch

      # Create a TelSearch instance from the common interface.
      # TelSearch requires the :api_token option to be set.
      def self.from_config(config)
        new(config.fetch(:api_token))
      end

      # @private
      # XML Namespaces, used to parse the data returned by tel.search.ch
      NS      = {'t' => 'http://tel.search.ch/api/spec/result/1.0/'}

      # @private
      # The url of the API of tel.search.ch
      API_URI = URI.parse('http://tel.search.ch/api')

      # @param [String] key
      #   The API key for the telsearch service.
      #   You can get one on http://admin.tel.search.ch/api/getkey
      def initialize(key)
        @key = key
        @uri = API_URI
      end

      # @private
      # Convert the abstracted APIs options to tel.search.ch's search params
      #
      # @param [Hash] params
      #   The abstract API search parameters
      def search_ch_mapping(params)
        {
          :was => params.values_at(:first_name, :family_name, :last_name, :maiden_name, :phone).compact.join(' '),
          :wo  => params.values_at(:street, :street_name, :street_number, :zip_code, :city).compact.join(' '),
        }.reject { |k,v| v.empty? }
      end

      # @see SwissMatch::Directories#addresses
      def addresses(params, options = {})
        return [] if params.empty? # short-cut

        # tel.search.ch parameters
        search_params = {'key' => @key}

        # Handle pagination parameters
        per_page = options[:per_page] || 10
        search_params['maxnum'] = per_page

        page = options[:page] || 1
        pos = (page - 1) * per_page + 1
        search_params['pos'] = pos

        # Request
        uri       = @uri.dup
        uri.query = URI.encode_www_form(search_ch_mapping(params).merge(search_params))
        feed      = Nokogiri.XML(open(uri, &:read))

        # Parse result
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

      # @private
      # Get the text from a node with the given selector
      def extract(node, selector)
        subnode = node.at_css(selector, NS)
        text    = subnode && subnode.text

        block_given? ? yield(text) : text
      end
    end
  end
end
