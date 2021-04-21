class PostsController < ApplicationController

    def all_posts
        Post.all
    end

    def find_by_id
        Post.find(params[:id])
    end

    def index
        render json: all_posts, include: [:communities, :users, :post_tags, :post_comments, :post_likes]
    end

    def show
        render json: find_by_id, includes: [:community, :user, :post_tags, :post_comments, :post_likes]
    end

    def create
        @post = Post.new(post_params)
        if @post.valid?
            @post.save
            render json: @post, message: "Post created by #{User.find(params[:user_id])} in #{Community.find(params[:community_id])}!"
        else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end

    private

    def post_params
        params.require(:post).permit :title, :content, :ip_address, :user_id, :community_id
    end

    # Only post_users or community owners should be able to delete a post
    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        render json: "Deleted #{@post}"
    end
end
