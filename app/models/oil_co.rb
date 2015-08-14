class OilCo < ActiveRecord::Base
  validates_presence_of :name

  default_scope -> {order(:name)}
end
