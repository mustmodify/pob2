module ARPhoneNumber
  def has_phone_number( field )
    define_method("#{field}=") do |input|
      write_attribute(field, PhoneNumber.strip(input))
    end

    define_method(field) do
      PhoneNumber.new(read_attribute(field)).to_s
    end
  end
end

ActiveRecord::Base.extend(ARPhoneNumber)
