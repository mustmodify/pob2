class UserSessionsController < ApplicationController

  # =================================
  # Actual authentication happens in
  # config/initializers/warden.rb
  # =================================

  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new

    respond_to do |format|
      format.html { render :layout => 'blank'}
      format.json { render_require_user }
    end
  end

  def challenge
    # rendered by warden when it can't authenticate
    # or by user_Sessions#create when that fails
    # see config/initializers/warden.rb
    @user_session = UserSession.new( params[:user_session] )
    @user_session.password = nil

    respond_to do |format|
      format.html { render template: 'user_sessions/new', status: :unauthorized, layout: 'blank' }
      format.json { render_require_user( status: :unauthorized ) }
    end
  end

  def show
    if current_user
      respond_to do |format|
        format.json { render_welcome }
        format.html { redirect_to root_path }
      end
    else
      respond_to do |format|
        format.json { render_require_user }
        format.html { redirect_to root_path }
      end
    end
  end

  def create
    warden.authenticate

    if( current_user )
      respond_to do |format|
        format.json { render_welcome }
        format.html { redirect_back_or_default(root_path) }
      end
    else
      flash.now[:warning] = 'Failed to login. Please try again.'
      challenge
    end
  end

  def auth
    warden.logout
    redirect_to root_path(token: params[:token])
  end

  def destroy
    warden.logout

    respond_to do |format|
      format.html { redirect_back_or_default new_user_session_url }
      format.json { render_require_user }
    end
  end

  private

  def render_welcome
    render :json => WelcomeEndpoint.new(:context => view_context, :collection => [ @user_session ] ).to_json, :status => :ok
  end

  def render_require_user(options = {})
#    options[:json] = UserSessionEndpoint.new(:context => view_context).to_json
    options[:json] = {error: 'who even are you?'}
    render options
  end
end

