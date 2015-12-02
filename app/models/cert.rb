class Cert < ActiveRecord::Base
  belongs_to :employee
  belongs_to :cert_name
  validates_presence_of :employee_id, :cert_name

  has_attached_file :image, :styles => { :original => "800x800>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => [/\Aimage\/.*\Z/, 'application/pdf']
  validates_attachment_presence :image

  def description
    self.cert_name.to_s
  end

  def extension
    #http://stackoverflow.com/questions/16803389/rails-how-to-get-a-file-extension-postfix-based-on-the-mime-type
    Rack::Mime::MIME_TYPES.invert[self.image.content_type]
  end

  def to_filename
    "#{description.to_key}#{extension}"
  end
end
