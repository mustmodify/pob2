class CustomaryCert < ActiveRecord::Base
  belongs_to :cert_name
  belongs_to :position

  validates_presence_of :cert_name, :position
  validates_uniqueness_of :cert_name_id, :scope => :position_id, :message => 'is already on the list.'
end
