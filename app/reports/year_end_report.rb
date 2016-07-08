class YearEndReport < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  has_value :year, klass: :integer, default: lambda{ Date.today.year - 1 }
  has_value :employee_id, klass: :integer
  has_value :project_id, klass: :integer

  class Datum < Valuable
    has_value :project_id
    has_value :employee_id
    has_value :days
    has_value :hours

    def project
      @p ||= Project.find( project_id )
    end

    def employee
      @e ||= Employee.find( employee_id )
    end
  end

  def start_date
    Date.new(self.year, 1, 1)
  end

  def end_date
    Date.new(self.year, 12, 31)
  end

  def results
    # Needs to be unioned with a query that handles jobs overlapping the beginning and end of the year.
    @results ||= Q.ask %|
      select project_id, employee_id, sum(hours) as hours, sum(days) as days FROM
        (select project_id, employee_id, DATEDIFF(offboarding_date, onboarding_date) as days, (DATEDIFF(offboarding_date, onboarding_date) * hours_per_day) as hours FROM jobs WHERE YEAR(onboarding_date) = #{self.year} AND YEAR(offboarding_date) = YEAR(onboarding_date) #{other_parts}) as indata GROUP BY employee_id, project_id|
  end

  def other_parts
    out = []
    out << "AND project_id = #{self.project_id.to_i}" if self.project_id
    out << "AND employee_id = #{self.employee_id}" if self.employee_id
    out.join(' ')
  end

  def total_days
    data.map(&:days).sum
  end

  def total_hours
    data.map(&:hours).sum
  end

  def ready?
    year.to_i > 1900
  end

  def data
    @data ||= ready? ? results.map{|result| Datum.new(result) } : []
  end

  def persisted?
    false
  end
end
