class OpsNote < ActiveRecord::Base
  validates :body, presence: true, length: {maximum: 50000}
end
