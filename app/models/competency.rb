class Competency < ActiveRecord::Base
  belongs_to :position
  belongs_to :employee
  validates_presence_of :employee, :position, :rate, :rate_interval, :rating

  def pay
    Pay.new(rate: self.rate, rate_interval: self.rate_interval)
  end
end
