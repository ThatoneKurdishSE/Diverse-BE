class CommunitiesController < ApplicationController

    def index
        @communities = Community.all

        render json: @communities
    end

    def show
        @community = Community.find(params[:id])

        render json: @community, includes: :users
    end

    def create
        @community = Community.new(community_params)
        if @community.valid?
            @community.save
            render json: @community, message: "Community Created!"
        else
            render json: @community.errors.full_messages, status: :unprocessable_entity
        end
    end

    private

    def community_params
        params.require(:community).permit(:name, :location, :description)
    end

    def destroy
        @community = Community.find(params[:id])
        @community.destroy

        render json: "Destroyed #{@community}"
    end

end
