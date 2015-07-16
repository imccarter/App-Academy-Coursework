class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: :destroy

  def create
    @user = User.find_by_credentials(
      user_params[:email],
      user_params[:password]
    )
    if @user.nil?
      @user = User.new
      @user.email = user_params[:email]
      flash[:errors] = @user.errors.full_messages
      render :new
    else
      @user.reset_session_token!
      login_user!(@user)
      #redirect_to
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    render :new
  end

  def redirect_if_logged_in
    if current_user
      #redirect_to ...
    end
  end
end
