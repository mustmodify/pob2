class Pay < Valuable
  has_value :rate
  has_value :rate_interval

  def blank?
    !rate
  end

  def rate_with_precision
    sprintf("%.2f", rate)
  end

  def to_s
    "$ #{rate_with_precision} per #{rate_interval}" unless blank?
  end
end
