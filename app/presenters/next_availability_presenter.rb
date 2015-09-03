class NextAvailabilityPresenter < Valuable
  has_value :employee

  def last_job
    @last_job ||= Job.where(employee_id: employee.id).order('onboarding_date desc').limit(1).first
  end

  def date_of_availability
    last_job && last_job.offboarding_date
  end

  def immediate?
    date_of_availability.try(&:past?) || date_of_availability.nil?
  end

  def known?
    !!date_of_availability
  end 
 
  def to_partial_path
    'employees/next_availability'
  end
 
  def to_s
    if immediate?
      'Available Now'
    elsif known?
      date_of_availability.to_s
    else
      'Offboarding date not set.'
    end
  end
end
