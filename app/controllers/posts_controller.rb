class PostsController < ApplicationController
  before_action :check_user, only: [:edit, :update]
  before_action :check_logged_in, only: [:new, :create]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def destroy

  end

  private

  def check_user
    @post = Post.find(params[:id])
    unless current_user.id == @post.author_id
      flash[:errors] = "You can't edit a post you didn't create."
      redirect_to post_url(@post)
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
