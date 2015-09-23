class Job < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  belongs_to :position

  validates_presence_of :onboarding_date, :offboarding_date
  validates_presence_of :project_id, :employee_id, :position_id

  def assignment
    Assignment.where(employee_id: self.employee_id, position_id: self.position_id, project_id: self.project_id).first
  end

  def competency
    Competency.where(employee_id: self.employee_id, position_id: self.position_id).first
  end

  def dates
    (onboarding_date..offboarding_date) if offboarding_date
  end

  def days
    (offboarding_date - onboarding_date).to_i if offboarding_date
  end

  def pay
    p = Pay.new(rate: self.rate, rate_interval: self.rate_interval)
    p unless p.blank?
  end

  def to_s
    "#{employee.to_s} from #{onboarding_date.to_s} to #{offboarding_date.to_s}"
  end
end
