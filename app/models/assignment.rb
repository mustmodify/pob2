class Assignment < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  belongs_to :position

  validates_presence_of :project_id, :employee_id, :position_id
  validates_uniqueness_of :position_id, :scope => [:project_id, :employee_id], message: 'has already been assigned to this position for this project.'

  validates_with CompetencyValidator, :if => :check_competence?

  def check_competence?
    @check_competence
  end

  def check_competence!
    @check_competence = true
  end

  def competency
    Competency.where(employee_id: self.employee_id, position_id: self.position_id).first
  end

  def normal_rate
    competency.try(&:rate)
  end
end