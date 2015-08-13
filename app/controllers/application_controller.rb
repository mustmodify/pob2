class ApplicationController < ActionController::Base
  include AppAuthentication
  include AppAuthorization

  before_filter :require_user

  helper_method :current_user

  protect_from_forgery with: :exception

  private

  def warden
    env['warden']
  end

  def self.no_authentication_for( *actions )
    skip_before_filter :require_user, :only => actions.flatten.compact
  end
end
