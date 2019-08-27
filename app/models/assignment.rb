class Assignment < ActiveRecord::Base
  belongs_to :employee
  belongs_to :project
  belongs_to :position

  validates_presence_of :employee_id, :project_id, :position_id
  validates_uniqueness_of :employee_id, message: "is already assigned to a project."

  validate :must_have_competency
  validate :must_not_be_termed

  def employee_competency_list
    employee.competencies.map(&:position).map(&:name).join(', ')
  end

  def must_have_competency
    self.errors.add(:position_id, "is not on this employee's list of competencies: (#{employee_competency_list})") if employee && position && !employee.competencies.where(position_id: self.position_id).any?
  end

  def must_not_be_termed
    self.errors.add(:employee_id, "must be an active employee") if employee && employee.status != 'Active'
  end

  def to_s
    "#{self.employee.name} as #{self.position.name} from #{self.created_at.to_date.to_s}"
  end
end
