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

    def unable_to_locate_post
        render json: { message: "Unable to located referenced post."}
    end

    def index
        render json: all_posts, includes: [:communities, :users, :post_tags, :post_comments, :post_likes]
    end

    def show
        @post = find_by_id
        if @post
            render json: @post, includes: [:community, :user, :post_tags, :post_comments, :post_likes]
        else
            unable_to_locate_post
        end
    end

    def create
        @user = User.find(post_params[:user_id])
        @community = Community.find(post_params[:community_id])

        if @user && @community
            @post = Post.new(post_params)
            if @post.valid?
                @post.save
                render json: @post, message: "Post created by #{get_user.username} in #{get_community.name}!"
            else
                render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
            end
        else
            if @user
              render json: { message: "User '#{@user.username}' passed successfully; Unable to locate referenced community."}
            elsif @community
              render json: { message: "Community '##{@community.name}' passed successfully; Unable to locate referenced user."}
            else
              render json: { message: "Neither user nor community were passed successfully, please review."}
            end
        end
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
        if @post
            @post.destroy
            render json: "Deleted #{get_user.username}'s '#{@post.title}' from ##{get_community.name}."
        else
            unable_to_locate_post
        end
    end
end
