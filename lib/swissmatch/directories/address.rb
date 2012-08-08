# encoding: utf-8



module SwissMatch
  module Directories

    # Represents a swiss address. Used by directory service interfaces to return search
    # results.
    Address = Struct.new(:gender, :first_name, :last_name, :maiden_name, :street_name, :street_number, :zip_code, :city) do

      # @return [String]
      #   The street and street number
      def street
        [street_name, street_number].compact.join(" ")
      end

      # @return [String]
      #   The full name, consisting of first_name and family_name.
      def full_name
        "#{first_name} #{family_name}"
      end

      # @return [String]
      #   The full family name, including the maiden name.
      #
      # @note
      #   I (stefan.rusterholz@gmail.com) am not sure whether "last_name (-maiden_name)"
      #   is the proper form. The output might be changed in a future version
      #   The current output is based on how tel.search.ch displays the name.
      def family_name
        maiden_name ? "#{last_name} (-#{maiden_name})" : last_name
      end

      # @return [String] A halfway readable textual representation
      def to_s
        "#{full_name}\n#{street}\n#{zip_code} #{city}"
      end
    end
  end
end
