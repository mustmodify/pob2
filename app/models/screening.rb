class Screening < ActiveRecord::Base
  belongs_to :employee

  has_attached_file :image, :styles => { :original => "800x800>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :employee, :date, :outcome
end