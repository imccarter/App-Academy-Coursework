class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  private

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def log_out!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def check_logged_in
    unless logged_in?
      if is_a?(SubsController)
        flash[:errors] = "Log in to create a sub."
      elsif is_a?(PostsController)
        flash[:errors] = "Log in to create a post."
      end
      redirect_to subs_url
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
