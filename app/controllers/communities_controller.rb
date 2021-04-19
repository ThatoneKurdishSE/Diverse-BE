class CommunitiesController < ApplicationController

    def index
        @communities = Community.all

        render json: @communities
    end

    def show
        @community = Community.find(params[:id])

        render json: @community
    end

    def create
        @community = Community.create(community_params)

        render json: @community, message: "Community Created!"
    end

    private

    def community_params
        params.require(:community).permit(:name, :location, :description)
    end

end
