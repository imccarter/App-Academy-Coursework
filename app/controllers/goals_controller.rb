class GoalsController < ApplicationController
  before_action :require_logged_in

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def index
    @goals = all_viewable_goals
    render :index
  end

  def show
    @goal = Goal.find(params[:id])
    if @goal.private_goal
      if !current_user.id == @goal.user_id
        redirect_to goals_url
      else
        render :show
      end
    else
      render :show
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_url
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :content, :private_goal)
  end

  def all_viewable_goals
    public_goals = Goal.where(private_goal: false)
    our_goals = Goal.where(private_goal: true, user_id: current_user.id)
    our_goals.concat(public_goals)
  end
end
