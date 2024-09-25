class EmploymentAction < ActiveRecord::Base
  ACTIONS = ['Prospect', 'Hire', 'Term']
  belongs_to :employee

  default_scope { where(deleted: false) }
  validates_inclusion_of :action, in: ACTIONS
  validates_presence_of :date
  validates_presence_of :employee
end
