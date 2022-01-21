class LikesController < ApplicationController
  def create
    like = Like.new(
      author_id: current_user.id,
      post_id: params[:post_id]
    )

    if like.save
      flash[:notice] = "You have successfully liked this post"
    else
      flash[:notice] = "You have not liked this post"
    end
    redirect_back(fallback_location: root_path)
  end
end
