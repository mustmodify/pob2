class DepartureSite < ActiveRecord::Base
  CATEGORIES = ['Heliport', 'Dock', 'Other']

  validates_presence_of :name
  default_scope -> {order(:name)}

  def to_s
    name
  end
end
