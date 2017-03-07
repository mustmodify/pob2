Rails.application.config.middleware.use Warden::Manager do |manager|
  # manager.default_strategies :session, :password, :perishable_token, :persistence_token
  manager.default_strategies [:perishable_token, :password, :cookie]
  manager.intercept_401 = false # when go_away renders :status => 401, warden ignores what it rendered and kicks you back out to the login page.

  manager.failure_app = lambda { |env| Rails.logger.warn "[AUTH] Failed to authenticate. Going to user_sessions#challenge."; UserSessionsController.action(:challenge).call(env) }
end

Warden::Manager.serialize_into_session do |user|
  user.persistence_token
end

Warden::Manager.serialize_from_session do |id|
  User.where(persistence_token: id).first
end

Warden::Manager.after_set_user do |user, auth, opts|
  if( user.login_count.blank? )
    user.update_attribute( :login_count, 1 )
  else
    user.update_attribute( :login_count, user.login_count + 1 )
  end

  Rack::Request.new(auth.env).cookies['user.remember.token'] = user.persistence_token
end

Warden::Manager.before_logout :scoper => :user do |user, auth, opts|
  Rack::Request.new(auth.env).cookies['user.remember.token'] = ""
end

Warden::Strategies.add(:password) do
  def valid?
    credential_params['email'] && credential_params['password']
  end

  def authenticate!
    email = credential_params['email']
    passwd = credential_params['password']

    Rails.logger.warn("[AUTH] Authenticating user #{email} via email and password")
    user = User.find_by_email(email)

    if user.blank?
      Rails.logger.warn("[AUTH] No Such User")
      fail "Invalid email or password"
    elsif user.authenticate( passwd )
      Rails.logger.warn("[AUTH] User #{user.email} authenticated with a password.")
      success! user
    else
      Rails.logger.warn("[AUTH] Bad Password")
      fail "Invalid email or password"
    end
  end

  def credential_params
    p = params.blank? ? post_params : params
    p['user_session'] || {}
  end

  def post_params
    @post_params ||= get_post_params
  end

  def get_post_params
    req = Rack::Request.new(env)

    if( req.post? )
      begin
        body = req.body.read
        req.body.rewind
        JSON.parse( body )
      rescue
        {'parse_error' => body.inspect}
      end
    else
      {}
    end
  end

end

Warden::Strategies.add(:perishable_token) do
  def valid?
    params['token']
  end

  def matching_user
    @match ||= User.where(perishable_token: params['token']).where('updated_at >= ?', Time.now - 10.days).first
  end

  def matching_expired_user
    @expired_match ||= User.where(perishable_token: params['token']).where('updated_at < ?', Time.now - 10.days).first
  end

  def authenticate!
    Rails.logger.warn("[AUTH] Authenticating user via token")
    if( matching_user )
      Rails.logger.warn("[AUTH] User #{matching_user.email} authenticated with a token.")
      matching_user.login_count ||= 0
      matching_user.reset_perishable_token!
      matching_user.update_attribute( :login_count, matching_user.login_count + 1 )
      success! matching_user
    elsif matching_expired_user
      Rails.logger.warn("[AUTH] Token for user #{matching_expired_user.email} HAS EXPIRED.")
      fail "Sorry, that link has expired."
    else
      Rails.logger.warn("[AUTH] No Such User")
      fail "Invalid email or password"
    end
  end
end

Warden::Strategies.add(:cookie) do
  Rails.logger.warn("[AUTH] Authenticating user via cookie")

  def cookie_token
    Rack::Request.new(auth.env).cookies['user.remember.token']
  end

  def valid?
    cookie_token.not.blank?
  end

  def authenticate!
    if user = User.where(persistence_token: cookie_token).first
      user.login_count ||= 0
      user.update_attribute(:login_count, user.login_count + 1)

      success! user
    else
      fail! "Could not log in"
    end
  end
end
