class NextAvailabilityPresenter < Valuable
  has_value :employee

  def last_job
    @last_job ||= nil
  end

  def next_job
    @next_job ||= nil
  end

  def current?
    false
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
    if current?
      'On a Job'
    elsif immediate?
      'Available Now'
    elsif date_of_next_commitment
      "Until #{date_of_next_commitment}"
    else
      'Offboarding date not set.'
    end
  end
end
