class POBSummaryReport < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  class Datum < Valuable
    has_value :employee
    has_value :project
    has_value :position
    has_value :start_date
    has_value :end_date

    has_value :hours_per_day
    has_value :rate_per_day

    has_value :onboarding_date
    has_value :offboarding_date

    def action(date = Date.today)
      if self.onboarding_date == date
        'On'
      elsif self.offboarding_date == date
        'Off'
      else
        nil
      end
    end

    def dates
      (start_date .. end_date).to_a
    end

    def days
      ((end_date - start_date) + 1).to_i
    end
  end

  has_value :start_date, :klass => Date, :parse_with => :parse
  has_value :end_date, :klass => Date, :parse_with => :parse
  has_value :employee_id, :klass => :integer
  has_value :project_id, :klass => :integer
  has_value :require_params, :default => false

  def employee
    Employee.find_by_id( self.employee_id )
  end

  def project
    Project.find_by_id( self.project_id )
  end

  def jobs
    scope = Job.where('1=1')
    scope = scope.where(employee_id: employee_id) if employee_id
    scope = scope.where(project_id: project_id) if project_id
    scope = scope.where('offboarding_date >= ?', self.start_date) if start_date
    scope = scope.where('onboarding_date <= ?', self.end_date) if end_date
    scope = scope.where('1 = 0') unless show_results
    scope
  end

  def show_results
    !( require_params && [start_date, end_date, employee_id].compact.size == 0 )
  end

  def data
    self.jobs.map do |job|
      Datum.new(
        :employee => job.employee,
        :project => job.project,
        :position => job.position,
        :start_date => [job.onboarding_date, self.start_date].compact.max,
        :end_date => [job.offboarding_date, self.end_date].compact.min,
        :hours_per_day => job.hours_per_day,
        :rate_per_day => job.daily_rate || job.assignment.try(&:daily_rate) || job.competency.try(:rate),
        :onboarding_date => job.onboarding_date,
        :offboarding_date => job.offboarding_date,
      )
    end.sort_by{|datum| [datum.employee.id, datum.start_date] }
  end

  def persisted?
    false
  end
end
