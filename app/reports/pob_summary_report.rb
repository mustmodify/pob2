class POBSummaryReport
  def onboardings
    CrewChange.where(action: 'In')
  end

  def matching_entry_for( onboarding )
    CrewChange.where(action: 'Out', employee_id: onboarding.employee_id, project: onboarding.project_id).where('date >= ?', onboarding.date).order('date asc').first
  end

  def pairs
    onboardings.map do |onboarding|
      [onboarding, matching_entry_for(onboarding)]
    end
  end

  def days_worked( on, off )
    (on.date..off.date).to_a.flatten
  end

  def data
    @data ||= generate_data
  end

  def generate_data
    {}.tap do |out|
      pairs.map do |on, off|
        out[on.employee] ||= []
        out[on.employee] += days_worked(on, off)
      end
    end
  end
end
