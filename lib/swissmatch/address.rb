# encoding: utf-8



module SwissMatch

  # Represents a swiss address. Used by directory service interfaces to return search
  # results.
  Address = Struct.new(:gender, :first_name, :last_name, :maiden_name, :street_name, :street_number, :zip_code, :city) do
    def street
      [street_name,street_number].compact.join(" ")
    end

    # @return [String]
    #   The full family name, including the maiden name.
    # @note
    #   I (stefan.rusterholz@gmail.com) am not sure whether "last_name (-maiden_name)"
    #   is the proper form. The output might be changed in a future version
    def family_name
      maiden_name ? "#{last_name} (-#{maiden_name})" : last_name
    end
  end
end
