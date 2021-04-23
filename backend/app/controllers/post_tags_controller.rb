class PostTagsController < ApplicationController

    def find_by_id
        PostTag.find(params[:id])
    end

    def get_post
        Post.find(@post_tag[:post_id])
    end

    def unable_to_locate_post_tag
        render json: { message: "Unable to locate referenced post tag."}
    end

    def show
        @post_tag = find_by_id
        if @post_tag
            render json: find_by_id, include: [:post]
        else
            unable_to_locate_post_tag
        end
    end

    def create
        @post = Post.find(post_tag_params[:post_id])
        if @post
            @post_tag = PostTag.new(post_tag_params)
            if @post_tag.valid?
                @post_tag.save
                render json: @post_tag, message: "##{@post_tag.tag_name} added to #{get_post.title}."
            else
                render json: { errors: @post_tag.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { message: "Post was not passed successfully, unable to add post tag."}
        end
    end

    private

    def post_tag_params
        params.require(:post_tag).permit(:tag_name, :post_id)
    end

    def destroy
        @post_tag = find_by_id
        if @post_tag
            @post_tag.destroy
            render json: { message: "##{@post_tag.tag_name} removed from #{get_post.title}." }
        else
            unable_to_locate_post_tag
        end
    end
end
