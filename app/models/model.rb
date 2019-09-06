module Model
  def stringly(att, h = {}, &block)

    max_length = h[:max_length] || 250

    define_method "#{att}=" do |value|
      if block
        value = block.call(value)
      end

      if value.nil?
        write_attribute(att, value)
      else
        # https://en.wikipedia.org/wiki/List_of_Unicode_characters
        # Keyboard characters are all below \u007F
        write_attribute(att, value.to_s.gsub(/[\u0080-\uFFFF]/, '').strip)
      end
    end

    validates_length_of att, maximum: max_length
  end
end
