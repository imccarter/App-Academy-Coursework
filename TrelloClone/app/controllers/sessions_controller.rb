class SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(params[:username], params[:password])
    if user
      log_in(user)
      redirect_to '/#'
    else
      flash.now[:errors] = ["Invalid log in"]
      render :new
    end
  end

  def new
  end

  def destroy
    log_out!
  end
end
