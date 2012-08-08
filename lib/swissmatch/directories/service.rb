# encoding: utf-8



require 'swissmatch/directories/address'
require 'swissmatch/directories/telsearch'



module SwissMatch
  module Directories

    # Common directory service API.
    #
    # @see SwissMatch::Directories Usage examples
    class Service

      # @param [Class, Symbol, #from_configuration] back_end
      #   A valid back-end. Valid in vanilla swissmatch-directories:
      #   * :telsearch
      #   * SwissMatch::Directories::TelSearch (same as :telsearch)
      # @param [Object] config
      #   A back-end specific configuration object.
      def initialize(back_end, config=nil)
        @service = SwissMatch::Directories.service(back_end).from_config(config)
      end

      # Query for addresses matching a set of given search parameters
      #
      # Note that not all back-ends will treat these parameters with the same strictness.
      # The tel.search.ch back-end for example will search for a last name anywhere in the name.
      #
      # @param [Hash] params
      #   The abstract API search parameters.
      #   Valid parameters:
      #   * :first_name
      #   * :family_name
      #   * :last_name
      #   * :maiden_name
      #   * :name
      #   * :phone
      #   * :street
      #   * :street_name
      #   * :street_number
      #   * :zip_code
      #   * :city
      def addresses(params, options={})
        @service.addresses(params, options)
      end
    end
  end
end
