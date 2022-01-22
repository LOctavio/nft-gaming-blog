class LikesController < ApplicationController
  def create
    like = Like.new(
      author_id: current_user.id,
      post_id: params[:post_id]
    )

    flash[:notice] = if like.save
                       'You have successfully liked this post'
                     else
                       'You have not liked this post'
                     end
    redirect_back(fallback_location: root_path)
  end
end
