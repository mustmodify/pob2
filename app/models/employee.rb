class Employee < ActiveRecord::Base
  validates_presence_of :first_name, :last_name

  has_attached_file :picture, :styles => { :medium => "225x225>", :thumb => "100x100>" }, :default_url => "/missing_employee_picture/:style.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/ 

  has_many :assignments
  has_many :certs, -> { joins(:cert_name).order('cert_names.name') }
  has_many :compliments
  has_many :contacts
  has_many :jobs
  has_many :notes
  has_many :reprimands
  has_many :restrictions # isn't that always the way?
  has_many :screenings
  has_many :expired_certs, -> { where('expires_on < ?', Date.today) }, :class_name => 'Cert'

  has_many :competencies
  accepts_nested_attributes_for :competencies, allow_destroy: true, reject_if: proc { |attributes| attributes['rate'].blank? }

  has_and_belongs_to_many :positions, :join_table => :competencies

  has_phone_number :cell_phone
  has_phone_number :home_phone
  has_phone_number :alt_phone

  scope :alphabetical, -> {order(:first_name, :last_name)}
  scope :active, -> {where(status: 'Active')}

  def phone_numbers
    {}.tap do |out|
      out['Home'] = self.home_phone if self.home_phone.not.blank?
      out['Cell'] = self.cell_phone if self.cell_phone.not.blank?
      out['Alt'] = self.alt_phone if self.alt_phone.not.blank?
    end
  end

  def ssn=(value)
    if value.blank?
      write_attribute(:ssn, nil)
    else
      write_attribute(:ssn, value.to_s.gsub(/[^\d]/, ''))
    end
  end

  def ssn
    x = read_attribute(:ssn)

    "#{x.to_s[0..2]}-#{x.to_s[3..4]}-#{x.to_s[5..8]}" unless x.blank?
  end

  def date_of_last_screening
    screenings.order('date').last.try(&:date)
  end

  def name
    [first_name, middle_name, last_name].compact.join(' ')
  end

  def next_availability
    @next_availability ||= NextAvailabilityPresenter.new(employee: self)
  end

  def to_s
    name
  end
end
