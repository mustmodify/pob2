class WorkSite < ActiveRecord::Base
  validates_presence_of :name
  default_scope -> {order(:name)}

  has_many :projects

  def removable?
    projects.empty?
  end

  def to_s
    name
  end
end
