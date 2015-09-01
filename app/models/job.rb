class Job < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  belongs_to :position

  validates_presence_of :onboarding_date, :offboarding_date
  validates_presence_of :project_id, :employee_id, :position_id

  def to_s
    "#{employee.to_s} from #{onboarding_date.to_s} to #{offboarding_date.to_s}"
  end
end
