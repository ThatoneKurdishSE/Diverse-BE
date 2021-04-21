class PostTagsController < ApplicationController

    def find_by_id
        PostTag.find(params[:id])
    end

    def get_post
        Post.find(@post_tag[:post_id])
    end

    def show
        render json: find_by_id, includes: [:post]
    end

    def create
        @post_tag = PostTag.new(post_tag_params)
        if @post_tag.valid?
            @post_tag.save
            render json: @post_tag, message: "##{@post_tag.tag_name} added to #{get_post.title}"
        else
            render json: { errors: @post_tag.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def post_tag_params
        params.require(:post_tag).permit(:tag_name, :post_id)
    end

    def destroy
        @post_tag = find_by_id
        @post_tag.destroy
        render json: { message: "##{@post_tag.tag_name} removed from #{get_post.title}" }
    end
end
