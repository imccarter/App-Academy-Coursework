class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ['Invalid username and/or password']
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    logout_user!
    redirect_to root_url
  end
end
