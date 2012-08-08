# encoding: utf-8



require 'swissmatch/directories/service'
require 'swissmatch/directories/version'



# __{SwissMatch::Directories}__
# Query address data from swiss online directory providers.
#
# @note
#   All strings passed to SwissMatch are expected to be utf-8. All strings
#   returned by SwissMatch are also in utf-8.
#
module SwissMatch

  # Query address data from swiss online directory providers.
  #
  # @example Usage
  #   require 'swissmatch/directories'
  #   directories = SwissMatch::Directories.create(:telsearch, api_token: your_token)
  #   params      = {first_name: 'Stefan', last_name: 'Rusterholz'}
  #   directories.addresses(params).each do |address|
  #     puts address,""
  #   end
  module Directories
    @services = Hash.new { |hash, key|
      if key.respond_to?(:from_configuration)
        key
      else
        raise ArgumentError, "Unknown service: #{key.inspect}"
      end
    }.merge(
      telsearch: SwissMatch::Directories::TelSearch
    )

    class <<self

      # @return [Hash] The available back-ends.
      attr_reader :services
    end

    # @return [Class] A SwissMatch::Directories::Service compatible service class.
    def self.service(name)
      services[name]
    end

    # @return [SwissMatch::Directories::Service] A directory service
    def self.create(name, options)
      Service.new(name, options)
    end
  end

  @directory_service  = nil

  class <<self

    # @return [SwissMatch::Directories::Service, nil]
    # The directory service used to search for addresses
    # You have to set this one yourself. It exists to provide a standard way to
    # 
    attr_accessor :directory_service
  end
end
