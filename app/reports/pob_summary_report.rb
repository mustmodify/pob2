class POBSummaryReport < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  class Datum < Valuable
    has_value :employee
    has_value :project
    has_value :position
    has_value :start_date
    has_value :end_date

    def days
      ((end_date - start_date) + 1).to_i
    end
  end

  has_value :start_date, :klass => Date, :parse_with => :parse
  has_value :end_date, :klass => Date, :parse_with => :parse
  has_value :employee_id, :klass => :integer
  has_value :project_id, :klass => :integer
  has_value :require_params, :default => false

  def onboardings
    scope = CrewChange.where(action: 'In')
    scope = scope.where('date >= ?', start_date) if start_date
    scope = scope.where('date <= ?', end_date) if end_date
    scope = scope.where(employee_id: employee_id) if employee_id
    scope = scope.where(project_id: project_id) if project_id
    scope = scope.where('1 = 0') unless show_results
    scope
  end

  def show_results
    !( require_params && [start_date, end_date, employee_id].compact.size == 0 )
  end

  def early_overlaps
    if start_date
      if employee_id
        c1 = "employee_id = #{employee_id}"
      else
        c1 = nil
      end

      if project_id
        c2 = "project_id = #{project_id}"
      else
        c1 = nil
      end

      c3 = "action = 'Out'"

      c4 = %|date = ( select MIN(t2.date) FROM crew_changes t2 WHERE t1.employee_id = t2.employee_id AND t2.date >= '#{start_date}' )|

      sql = %|select t1.id FROM crew_changes t1 WHERE #{[c1, c2, c3, c4].compact.join(' AND ')}|
puts sql
      results = ActiveRecord::Base.connection.select_values sql

      candidates = CrewChange.where(id: results)

      candidates.select do |candidate|
        candidate.action == 'Out'
      end
    else
      []
    end
  end

  def matching_onboarding_for( offboarding )
    CrewChange.where(action: 'In', employee_id: offboarding.employee_id, project: offboarding.project_id).where('date < ?', offboarding.date).order('date asc').first
  end

  def matching_offboarding_for( onboarding )
    CrewChange.where(action: 'Out', employee_id: onboarding.employee_id, project: onboarding.project_id).where('date > ?', onboarding.date).order('date asc').first
  end

  def pairs
    [].tap do |out|
      early_overlaps.each do |offboarding|
        onboarding = matching_onboarding_for( offboarding )
        out << [matching_onboarding_for(offboarding), offboarding]
      end

      onboardings.map do |onboarding|
        out << [onboarding, matching_offboarding_for(onboarding)]
      end
    end
  end

  def data
    pairs.map do |onboarding, offboarding|
      Datum.new(
        :employee => onboarding.employee,
        :project => onboarding.project,
        :position => onboarding.position,
        :start_date => [onboarding.date, self.start_date].compact.max,
        :end_date => [offboarding.date, self.end_date].compact.min
      )
    end.sort_by{|datum| [datum.employee.id, datum.start_date] }
  end

  def persisted?
    false
  end
end
