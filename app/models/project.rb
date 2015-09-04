class Project < ActiveRecord::Base

  belongs_to :oil_co
  belongs_to :customer

  belongs_to :departure_site
  belongs_to :work_site

  has_many :assignments
  has_many :employees, through: :assignments
  has_many :jobs, -> { order('onboarding_date') }

  scope :visible, -> { where('start_date <= ?', 1.month.from_now).where('end_date >= ?', 1.month.ago)}

  validates_presence_of :name

  has_phone_number :phone

  def to_s
    name
  end
end
