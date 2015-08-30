class SubsController < ApplicationController
  before_action :check_moderator, only: [:edit, :update]
  before_action :check_logged_in, only: [:new, :create]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def check_moderator
    @sub = Sub.find(params[:id])
    unless current_user.id == @sub.moderator_id
      flash[:errors] = "Can't edit a sub unless you're the moderator"
      redirect_to sub_url(@sub)
    end
  end
end
