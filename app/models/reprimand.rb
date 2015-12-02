class Reprimand < ActiveRecord::Base
  belongs_to :category, :class_name => 'ReprimandCategory', :foreign_key => :reprimand_category_id
  belongs_to :employee

  validates_presence_of :category, :employee, :date

  has_attached_file :image, :styles => { :original => "800x800>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => [/\Aimage\/.*\Z/, 'application/pdf']
end
