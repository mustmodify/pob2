class Contact < ActiveRecord::Base
  belongs_to :employee

  validates_presence_of :name, :relationship

  has_phone_number :home_phone
  has_phone_number :cell_phone
  has_phone_number :alt_phone
end
