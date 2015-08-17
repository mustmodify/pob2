class CrewChange < ActiveRecord::Base
  belongs_to :project
  belongs_to :employee
  belongs_to :position

  validates_presence_of :date, :project, :action, :employee,
                        :position, :rate

end
