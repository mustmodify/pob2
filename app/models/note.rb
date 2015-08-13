class Note < ActiveRecord::Base
  belongs_to :author, :class_name => 'User'
  belongs_to :employee

  validates_presence_of :author, :employee, :body
end
