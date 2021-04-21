class CommentsController < ApplicationController

    def find_by_id
        Comment.find(params[:id])
    end

    def get_user
        User.find(@comment[:user_id])
    end

    def get_post
        Post.find(@comment[:post_id])
    end

    def show
        render json: find_by_id
    end

    def create
        @comment = Comment.new(comment_params)
        if @comment.valid?
            @comment.save
            render json: @comment, message: "#{get_user.username} commented on #{get_post.title}"
        else
            render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :user_id, :post_id)
    end

    def destroy
        @comment = find_by_id
        @comment.destroy
        render json: { message: "#{get_user.username} deleted comment from #{get_post.title}" }
    end
end
