class UserSession < Valuable
  include ActiveModel::Model

  has_value :email
  has_value :password

  has_value :remember_me, :default => true, :klass => :boolean
end
