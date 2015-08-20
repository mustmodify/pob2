class Compliment < ActiveRecord::Base
  belongs_to :employee
  validates_presence_of :date, :note
end
