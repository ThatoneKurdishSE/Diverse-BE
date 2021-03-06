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

    def unable_to_locate_comment
        render json: { message: "Unable to locate referenced comment."}
    end

    def show
        @comment = find_by_id
        if @comment
            render json: @comment, include: [:user, :post]
        else
            unable_to_locate_comment
        end
    end

    def create
        @user = User.find(comment_params[:user_id])
        @post = Community.find(comment_params[:post_id])

        if @user && @post
            @comment = Comment.new(comment_params)
            if @comment.valid?
                @comment.save
                render json: @comment, message: "#{get_user.username} commented on #{get_post.title}."
            else
                render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
            end
        else
            if @user
                render json: { message: "User '#{@user.username}' passed successfully; Unable to locate referenced post."}
            elsif @post
                render json: { message: "Post '#{@post.title}' passed successfully; Unable to locate referenced user."}
            else
                render json: { message: "Neither user nor post were passed successfully, please review."}
            end
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :user_id, :post_id)
    end

    def destroy
        @comment = find_by_id
        if @comment
            @comment.destroy
            render json: { message: "#{get_user.username} deleted comment from #{get_post.title}." }
        else
            unable_to_locate_comment
        end
    end
end
