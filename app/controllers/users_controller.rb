class UsersController < ApplicationController

  def index
    if !current_user.can_read? :users
      go_away
    else
      @users = User.all
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      warden.set_user( @user )
      redirect_to root_path
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find( params[:id] )

    if  @user.update_attributes(user_params)
      flash[:success] = 'User was successfully updated.'
      redirect_to root_path
    else
      render :action => "edit"
    end
  end

  def edit
    @user = User.find( params[:id] )

    if !current_user.can_update? @user
      go_away
    end
  end

  def destroy
    @user = User.find( params[:id] )

    if !current_user.can_delete? @user
      go_away
    else
      flash[:success] = "Deleted user #{@user.email}"
      @user.destroy

      redirect_to(users_url)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :commit)
  end
end

