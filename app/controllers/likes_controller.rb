class LikesController < ApplicationController
    def create
        like = Like.new(
        author_id: current_user.id,
        post_id: params[:post_id]
        )

        if like.save
            redirect_to user_post_path(id: params[:post_id])
        end
    end
end
