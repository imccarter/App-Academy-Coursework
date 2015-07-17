class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    log_in!(@user)

    if @user.save
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user
      render :show
    else
      flash[:errors] = ["Log in to view your profile"]
      redirect_to new_session_url
    end
  end
end
