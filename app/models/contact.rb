class Contact < ActiveRecord::Base
  belongs_to :employee

  validates_presence_of :name, :relationship
end
