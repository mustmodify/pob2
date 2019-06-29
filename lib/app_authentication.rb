module AppAuthentication

  private

  def current_user
    @current_user ||= detect_and_log_user
  end

  def log_user( user )
    if user.nil?
      logger.info("  User: Anonymous")
    else
      logger.info("  User: #{user.email} <>")
    end
  end

  def detect_and_log_user
    ( session_user || authenticated_user || remembered_user ).tap do |user|
      log_user( user )
    end
  end

  def remembered_user
    u = User.where(persistence_token: cookies.signed[:remember_me]).first
    if u
      Rails.logger.info("[AUTH] manually authenticating user #{u.id} because Warden is dumb.")
      warden.set_user(u)
    end
    u
  end

  def session_user
    warden.user
  end

  def authenticated_user
    warden.authenticate
  end
end

