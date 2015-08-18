class Competency < ActiveRecord::Base
  belongs_to :position
  belongs_to :employee
  validates_presence_of :employee, :position, :rate
end
