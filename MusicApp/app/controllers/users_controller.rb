class UsersController < ApplicationController
  before_action :redirect_if_logged_in, except: :show

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!(@user)
      redirect_to user_url(@user.id)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    render :show
  end
end
