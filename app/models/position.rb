class Position < ActiveRecord::Base
  validates_presence_of :name
  has_and_belongs_to_many :employees, :join_table => :competencies

  def to_s
    name
  end
end
