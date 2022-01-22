class PostsController < ApplicationController
  def new
    @post = Post.new
    @user = User.find(current_user.id)
  end

  def create
    @user = User.find(current_user.id)
    @post = @user.posts.new(post_params)

    if @post.save
      redirect_to @user
      flash[:notice] = 'You have successfully created a post'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'Your post was not created'
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :comments_counter, :likes_counter)
  end
end
