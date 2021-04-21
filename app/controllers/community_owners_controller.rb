class CommunityOwnersController < ApplicationController

  def all_community_owners
    CommunityOwner.all
  end

  def find_by_id
    CommunityOwner.find(params[:id])
  end

  def get_user
    User.find(@community_owner[:user_id])
  end

  def get_community
    Community.find(@community_owner[:community_id])
  end

  def unable_to_locate_community_owner
    render json: { message: "Unable to locate referenced community owner."}
  end

  def index
    render json: all_community_owners, includes: %i[users communities]
  end
  
  def show
    @community_owner = find_by_id
    if @community_owner
      render json: @community_owner, includes: %i[users communities]
    else
      unable_to_locate_community_owner
    end
  end

  def create
    @user = User.find_by(id: community_owner_params[:user_id])
    @community = Community.find_by(id: community_owner_params[:community_id])

    if @user && @community
      @community_owner = CommunityOwner.new(community_owner_params)
      if @community_owner.valid?
        @community_owner.save
        render json: @community_owner, message: "#{@user.username} became an owner of ##{@community.name}."
      else
        render json: { errors: @community_owner.errors.full_messages }, status: :unprocessable_entity
      end
    else
      if @user
        render json: { message: "User #{@user.username} passed successfully; Unable to locate referenced community."}
      elsif @community
        render json: { message: "Community ##{@community.name} passed successfully; Unable to locate referenced user."}
      else
        render json: { message: "Neither user nor community were passed successfully, please review."}
    end
  end

  private

  def community_owner_params
    params.require(:community_owner).permit :user_id, :community_id
  end
  
  def destroy
    @community_owner = CommunityOwner.find(params[:id])
    if @community_owner
      @community_owner.destroy
      render json: "Removed #{get_user.username} as an owner of ##{get_community.name}."
    else
      unable_to_locate_community_owner
    end
  end
end
  