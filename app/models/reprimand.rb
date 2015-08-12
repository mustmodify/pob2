class Reprimand < ActiveRecord::Base
  belongs_to :category, :class_name => 'ReprimandCategory', :foreign_key => :reprimand_category_id
  belongs_to :employee

  validates_presence_of :category, :employee, :date
end
