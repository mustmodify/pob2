class NextAvailabilityPresenter < Valuable
  has_value :employee

  def current?
    !employee.assignment.blank?
  end

  def to_partial_path
    'employees/next_availability'
  end

  def to_s
    if current?
      'Unavailable'
    else
      'Available'
    end
  end
end
