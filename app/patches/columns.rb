module ArrayColumnFormatting
  def column_max_widths
    self.reduce([]) do |maxes, list|
      list.each_with_index do |value, index|
        maxes[index] = [(maxes[index] || 0), value.to_s.length].max
      end
      maxes
    end
  end

  def display
    maxes = column_max_widths(hashes)
    self.each do |row|
      row.each_with_index do |value, index|
        print " #{value.to_s.rjust(maxes[index])},"
      end
      puts
    end
  end
end

module HashColumnFormatting
  def column_max_widths 
    self.reduce({}) do |maxes, hash|
      hash.keys.each do |key|
        maxes[key] = [(maxes[key] || 0), key.to_s.length].max
        maxes[key] = [(maxes[key] || 0), hash[key].to_s.length].max
      end
      maxes
    end
  end

  def display 
    maxes = column_max_widths 
  
    return if hashes.empty?
  
    # Headers
    self.first.each do |key, value|
      print " #{key.to_s.rjust(maxes[key])},"
    end
    puts
  
    self.each do |hash|
      hash.each do |key, value|
        print " #{value.to_s.rjust(maxes[key])},"
      end
      puts
    end
  end
end
