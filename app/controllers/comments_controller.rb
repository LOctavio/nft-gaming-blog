class CommentsController < ApplicationController
    def create
        comment = Comment.new(
        text: params[:text],
        author_id: current_user.id,
        post_id: params[:post_id]
        )

        if comment.save
            redirect_to user_post_path(id: params[:post_id])
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:text)
    end
end
