class PostLikesController < ApplicationController

    def find_by_id
        PostLike.find(params[:id])
    end

    def get_user
        User.find(@post_like[:user_id])
    end

    def get_post
        Post.find(@post_like[:post_id])
    end

    def unable_to_locate_post_like
        render json: { message: "Unable to locate referenced post like."}
    end

    def show
        @post_like = find_by_id
        if @post_like
            render json: find_by_id, includes: [:user, :post]
        else
            unable_to_locate_post_like
        end
    end

    def create
        @user = User.find(post_like_params[:user_id])
        @post = Community.find(post_like_params[:post_id])

        if @user && @post
            @post_like = PostLike.new(post_like_params)
            if @post_like.valid?
                @post_like.save
                render json: @post_like, message: "#{get_user.username} liked #{get_post.title}."
            else
                render json: { errors: @post_like.errors.full_messages }, status: :unprocessable_entity
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

    def post_like_params
        params.require(:post_like).permit(:user_id, :post_id)
    end

    def destroy
        @post_like = find_by_id
        if @post_like
            @post_like.destroy
            render json: { message: "#{get_user.username} unliked #{get_post.title}." }
        else
            unable_to_locate_post_like
        end
    end
end
