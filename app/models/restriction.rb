class Restriction < ActiveRecord::Base

  belongs_to :employee

  validates_presence_of :title

  has_attached_file :attachment, :styles => { :medium => "800x800>", :thumb => "200x350>" }
  validates_attachment_content_type :attachment, :content_type => /\Aimage\/.*\Z/ 

  def to_s
    "#{title} for #{employee.to_s}"
  end
end
