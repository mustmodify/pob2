class Position < ActiveRecord::Base
  validates_presence_of :name, :rate
  has_and_belongs_to_many :employees, :join_table => :competencies
end
