class Employee < ActiveRecord::Base
  validates_presence_of :first_name, :last_name

  has_attached_file :picture, :styles => { :medium => "225x225>", :thumb => "100x100>" }, :default_url => "/missing_employee_picture/:style.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/ 

  def phone_numbers
    {}.tap do |out|
      out['Home'] = self.home_phone if self.home_phone.not.blank?
      out['Cell'] = self.cell_phone if self.cell_phone.not.blank?
      out['Alt'] = self.alt_phone if self.alt_phone.not.blank?
    end
  end

  def name
    [first_name, middle_name, last_name].compact.join(' ')
  end
end
