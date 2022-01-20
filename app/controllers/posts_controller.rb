class PostsController < ApplicationController
  def new
    @post = Post.new
    @user = User.find(current_user.id)
  end

  def create
    @user = User.find(current_user.id)
    @post = @user.posts.new(post_params)

    redirect_to @user if @post.save
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end
end
