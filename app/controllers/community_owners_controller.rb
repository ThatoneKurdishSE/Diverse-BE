class CommunityOwnersController < ApplicationController
    def index
      @community_owners = CommunityOwner.all
  
      render json: @community_owners, includes: %i[users communities]
    end
  
    def show
      @community_owner = CommunityOwner.find(params[:id])
  
      render json: @community_owner, includes: %i[users communities]
    end
  
    def create
      @user = User.find_by(id: community_owner_params[:user_id])
      @community = Community.find_by(id: community_owner_params[:community_id])
  
      if @user && @community
        @community_owner = CommunityOwner.create(community_owner_params)
        render json: @community_owner, message: "#{@user.username} became an owner of ##{@community.name}"
      else
        render json: 'Unable to create CommunityOwner, please review.'
      end
    end
  
    private
  
    def community_owner_params
      params.require(:community_owner).permit :user_id, :community_id
    end
  
    def destroy
      @community_owner = CommunityOwner.find(params[:id])
      @community_owner.destroy
  
      render json: "Destroyed #{@community_owner}"
    end
  end
  