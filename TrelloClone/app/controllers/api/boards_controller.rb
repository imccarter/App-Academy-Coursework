require 'byebug'
class Api::BoardsController < ApplicationController
  before_action :require_log_in

  def index
    @boards = current_user.boards
    render 'index'
  end

  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    # debugger
    if !@board.save
      flash[:errors] = @board.errors.full_messages
    end
    # render json: @board
    render 'show'
  end

  def destroy
    @board = Board.find(params[:id])
    @board.destroy!
    render 'show'
  end

  def new
    @board = Board.new()
  end

  def show
    @board = Board.find(params[:id])
    render 'show'
  end

  private
  def board_params
    params.require(:board).permit(:title, :user_id)
  end
end
