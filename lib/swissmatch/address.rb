# encoding: utf-8



module SwissMatch

  # Represents a swiss address. Used by directory service interfaces to return search
  # results.
  Address = Struct.new(:gender, :first_name, :last_name, :maiden_name, :street_name, :street_number, :zip_code, :city) do
    def street
      [street_name,street_number].compact.join(" ")
    end

    # Full family name including the maiden name
    def family_name
      name = last_name
      name += " (-#{maiden_name})" if maiden_name.present?
    end
  end
end
