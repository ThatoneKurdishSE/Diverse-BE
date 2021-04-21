class PostsController < ApplicationController

    def all_posts
        Post.all
    end

    def find_by_id
        Post.find(params[:id])
    end

    def get_user
        User.find(@post[:user_id])
    end

    def get_community
        Community.find(@post[:community_id])
    end

    def index
        render json: all_posts, includes: [:communities, :users, :post_tags, :post_comments, :post_likes]
    end

    def show
        render json: find_by_id, includes: [:community, :user, :post_tags, :post_comments, :post_likes]
    end

    def create
        @post = Post.new(post_params)
        if @post.valid?
            @post.save
            render json: @post, message: "Post created by #{get_user.username} in #{get_community.name}!"
        else
            render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end

    def search_by_title
        search_title = params[:search_criteria].downcase
        User.where( 'username LIKE ?', "%#{search_title}%")
    end
    
    def search
        if params[:search_criteria]
            @search_results = search_by_title
            if @search_results.length > 0
                render json: @search_results
            else
                render json: all_posts, message: "No results found, please try searching something else."
            end
        else
            render json: all_posts
        end
    end

    private

    def post_params
        params.require(:post).permit :title, :content, :ip_address, :user_id, :community_id
    end

    # Only post_users or community owners should be able to delete a post
    def destroy
        @post = find_by_id
        @post.destroy

        render json: "Deleted #{@post}"
    end
end
