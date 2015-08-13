class User < ActiveRecord::Base
  include User::Abilities
  include User::Tokens

  has_many :organizations, :foreign_key => :manager_id
  has_one :business, :class_name => 'Organization', :foreign_key => :manager_id
  before_create :set_tokens

  has_secure_password
  validates_presence_of :password, on: :create
  validates_uniqueness_of :email
  validates_format_of :email, :with => EMAIL_PATTERN, :message => "doesn't look like an email address"

  has_many :subscriptions, as: :subscriber

  def name
    [first_name, last_name].join(' ')
  end

  def to_s
    email
  end
end

