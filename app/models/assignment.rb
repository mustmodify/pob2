class Assignment < ActiveRecord::Base
  belongs_to :employee
  belongs_to :project
  belongs_to :position

  validates_presence_of :employee_id, :project_id, :position_id
  validate :must_have_competency

  def employee_competency_list
    employee.competencies.map(&:position).map(&:name).join(', ')
  end

  def must_have_competency
    self.errors.add(:position_id, "is not on this employee's list of competencies: (#{employee_competency_list})") if employee && position && !employee.competencies.where(position_id: self.position_id).any?
  end
end
