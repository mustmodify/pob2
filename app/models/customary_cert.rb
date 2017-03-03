class CustomaryCert < ActiveRecord::Base
  belongs_to :cert_name
  belongs_to :position

  validates_presence_of :cert_name, :position
end
