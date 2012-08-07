# encoding: utf-8



require 'swissmatch/address'
require 'swissmatch/directoryservice'
require 'swissmatch/telsearch'
require 'swissmatch/directories/version'



# From SwissMatch::Directories
# Query address data from swiss directory providers.
#
# @note
#   All strings passed to SwissMatch are expected to be utf-8. All strings
#   returned by SwissMatch are also in utf-8.
#
module SwissMatch
  @directory_service  = nil

  class <<self
    # @return [SwissMatch::DirectoryService, nil]
    # The directory service used to search for addresses
    attr_accessor :directory_service
  end
end
