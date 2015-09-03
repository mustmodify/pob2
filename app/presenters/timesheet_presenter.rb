class TimesheetPresenter < Valuable
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  has_value :employee, :klass => Employee, :parse_with => :find_by_id, :alias => :employee_id
  has_value :project, :klass => Project, :parse_with => :find_by_id, :alias => :project_id
  has_value :start_date, :klass => Date, :parse_with => :parse
  has_value :end_date, :klass => Date, :parse_with => :parse

  def employee_id
    self.employee.try(&:id)
  end

  def project_id
    self.project.try(&:id)
  end

  def show_results
    self.start_date && self.end_date
  end

  def jobs
    if show_results
      POBSummaryReport.new(
        :employee_id => self.employee.try(&:id),
        :project_id => self.project.try(&:id),
        :start_date => self.start_date,
        :end_date => self.end_date,
        :require_params => true
      ).data
    else
      []
    end
  end

  def persisted?
    false
  end
end
