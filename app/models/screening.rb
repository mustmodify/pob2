class Screening < ActiveRecord::Base
  belongs_to :employee

  CATEGORIES = ['Alcohol', 'Drug', 'Physical']
  OUTCOMES = ['Pass', 'Fail', 'Med Hold']

  has_attached_file :image, :default_url => "/assets/file-missing.png"
  validates_attachment_content_type :image, :content_type => [/\Aimage\/.*\Z/, 'application/pdf']
  validates_presence_of :outcome

  validates_presence_of :employee, :date, :outcome
  validates_inclusion_of :category, :in => CATEGORIES, :allow_blank => false
  validate :check_outcome

  def check_outcome
    if outcome == 'Med Hold' && category != 'Physical'
      self.errors[:outcome] << "Med Hold can only be used for physicals."
    end
  end
end
