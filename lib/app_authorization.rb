module AppAuthorization

  private

  def require_role(role)
    return false unless require_user
    current_user.has_role?(role)
  end

  def require_admin
    if current_user.blank?
      require_user
    else
      go_away "You must be an admin to access this page" unless(current_user.admin?)
    end
  end

  def go_away(message = nil)
    message ||= env["warden"].message || "You don't have permission to do that."
    Rails.logger.info("[GO AWAY] #{message}")

    respond_to do |format|
      format.html do
        if current_user
          render :text => message, :layout => 'blank', :status => :unauthorized
        else
          redirect_to new_user_session_path, :warning => message
        end
      end

      format.json { render :json => GoAwayEndpoint.new(:context => self).to_json, :status => :unauthorized }
      format.js { render :partial => 'layouts/go_away' }
      format.xml { render :text => '<error>Please Authenticate</error>', :status => :unauthorized }
      format.all { render :text => 'not authorized', :status => :unauthorized }
    end
  end

  def require_user
    if current_user
      current_user.update_attribute(:last_request_at, Time.now())
    else
      respond_to do |format|
        format.html do
          store_location
          go_away
        end
        format.xml  { render :xml => '<errors><error>No User Authorization</error></errors>', :status => :unauthorized }
        format.json { redirect_to new_user_session_path(format: :json) }
        format.all {
          store_location
          redirect_to new_user_session_path
        }
      end

      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to '/logout'
      return false
    end
  end

  def store_location
    session[:return_to] = request.url unless params[:controller] == 'user_sessions' || request.method == 'POST'
  end

  def redirect_back_or_default(default = dashboard_path)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def authorize_for( object )
    if( current_user.can_view?( object ) )
      if block_given?
        yield
      else
        render :action => 'show'
      end
    else
      go_away
    end
  end
end

