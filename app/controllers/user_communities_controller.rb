class UserCommunitiesController < ApplicationController

    def index
        @user_communities = UserCommunity.all

        render json: @user_communities, includes: [:users, :communities]
    end

    def show
        @user_community = UserCommunity.find(params[:id])

        render json: @user_community, includes: [:users, :communities]
    end

    def create
        @user = User.find_by(id: user_community_params[:user_id])
        @community = Community.find_by(id: user_community_params[:community_id])

        if @user && @community
            @user_community = UserCommunity.create(user_community_params)
            render json: @user_community, message: "Created new User Community!"
        else
            render json: "Unable to create UserCommunity, please review."
        end
    end

    private

    def user_community_params
        params.require(:user_community).permit :user_id, :community_id
    end

    def destroy
        @user_community = UserCommunity.find(params[:id])
        @user_community.destroy

        render json: "Destroyed #{@user_community}"
    end

end
