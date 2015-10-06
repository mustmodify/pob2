class PhoneNumber < String
  def initialize(value)
    super(value.to_s)
  end

  def full_number?
    has_ten_digits?
  end

  def has_ten_digits?
    self =~ /\d{10}/
  end

  def inspect
    self.to_s
  end

  def self.strip( input )
    input && input.gsub(/[^\d]*/, '')
  end

  def to_s
    if full_number?
      "(#{self[0..2]}) #{self[3..5]}-#{self[6..9]}"
    elsif self.length > 0
      "#{self[0..2]}-#{self[2..-1]}"
    end
  end
end
