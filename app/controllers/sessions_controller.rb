class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: :destroy

  def create
    @user = User.find_by_credentials(
      user_params[:email],
      user_params[:password]
    )
    if @user.nil?
      @user = User.new
      flash[:errors] = @user.errors.full_messages
      render :new
    else
      @user.reset_session_token!
      log_in_user!(@user)
      redirect_to user_url(@user.id)
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

end
