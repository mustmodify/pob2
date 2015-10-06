class NextAvailabilityPresenter < Valuable
  has_value :employee

  def last_job
    @last_job ||= Job.where(employee_id: employee.id).order('onboarding_date').limit(1).last
  end

  def next_job
    @next_job ||= Job.where(employee_id: employee.id).where('onboarding_date > ?', Date.today).order('onboarding_date').limit(1).first
  end

  def date_of_next_commitment
    next_job && next_job.onboarding_date
  end

  def date_of_availability
    last_job && last_job.offboarding_date
  end

  def immediate?
    date_of_next_commitment.nil?
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
    elsif date_of_next_commitment
      "Until #{date_of_next_commitment}"
    else
      'Offboarding date not set.'
    end
  end
end
