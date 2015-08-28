class Cert < ActiveRecord::Base
  belongs_to :employee
  belongs_to :cert_name
  validates_presence_of :employee_id, :cert_name

  has_attached_file :image, :styles => { :original => "800x800>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_presence :image
end
