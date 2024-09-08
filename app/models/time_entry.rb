class TimeEntry < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :employee

  validates_presence_of :employee
  validates_presence_of :hours
  validates_presence_of :date

  def to_s
    "#{employee.name} on #{date.to_s(:mdy)} for #{hours} hours"
  end
end
