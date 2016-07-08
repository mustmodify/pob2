class Project < ActiveRecord::Base

  belongs_to :oil_co
  belongs_to :customer

  belongs_to :departure_site
  belongs_to :work_site

  has_many :assignments, -> { joins(:employee).order('employees.first_name, employees.last_name') }, dependent: :destroy
  has_many :employees, through: :assignments
  has_many :jobs, -> { order('onboarding_date') }, dependent: :destroy

  scope :visible, -> { where('start_date <= ?', 1.month.from_now).where('end_date >= ?', 1.month.ago)}

  validates_presence_of :name

  has_phone_number :phone

  scope :alphabetical, -> {order(:name)}

  def removable?
    assignments.empty? && jobs.empty?
  end

  def to_s
    name
  end
end
