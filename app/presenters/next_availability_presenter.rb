class NextAvailabilityPresenter < Valuable
  has_value :employee

  def is_available?
    employee.assignment.nil?
  end

  def to_partial_path
    'employees/next_availability'
  end

  def to_s
    if is_available?
      'Available'
    else
      'Unavailable'
    end
  end
end
