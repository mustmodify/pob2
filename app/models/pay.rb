class Pay < Valuable
  has_value :rate
  has_value :rate_interval

  def blank?
    !rate
  end

  def to_s
    "$ #{rate} per #{rate_interval}" unless blank? 
  end
end
