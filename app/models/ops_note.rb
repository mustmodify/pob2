class OpsNote < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  validates :body, presence: true, length: {maximum: 50000}
end
