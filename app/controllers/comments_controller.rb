class CommentsController < ApplicationController
  def show
    @comment = Comment.find(params[:id])
    render :show
  end

end
