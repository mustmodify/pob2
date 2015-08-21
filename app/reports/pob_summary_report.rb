class POBSummaryReport < Valuable

  has_value :start_date, :klass => Date, :parse_with => :parse
  has_value :end_date, :klass => Date, :parse_with => :parse
  has_value :employee_id

  def onboardings
    scope = CrewChange.where(action: 'In')
    scope = scope.where('date >= ?', start_date) if start_date
    scope = scope.where('date <= ?', end_date) if end_date
    scope = scope.where(employee_id: employee_id) if employee_id
    scope
  end

  def early_overlaps
    candidates = CrewChange.where('date >= ?', start_date).order('date asc').group('employee_id')
    candidates = candidates.where(employee_id: employee_id) if employee_id

    candidates.select do |candidate|
      candidate.action == 'Out'
    end
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
    last_reportable_date = [off.date, end_date].compact.min
    (on.date..last_reportable_date).to_a.flatten
  end

  def data
    @data ||= generate_data
  end

  def generate_data
    {}.tap do |out|
      early_overlaps.each do |offboarding|
        out[offboarding.employee] ||= []
        out[offboarding.employee] += (start_date..offboarding.date).to_a
      end

      pairs.map do |on, off|
        out[on.employee] ||= []
        out[on.employee] += days_worked(on, off)
      end
    end
  end
end
