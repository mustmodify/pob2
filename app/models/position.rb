class Position < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :employees, :join_table => :competencies
  has_many :jobs
  has_many :competencies

  def removable?
    employees.empty? && jobs.empty? && competencies.empty?
  end

  def to_s
    name
  end
end
