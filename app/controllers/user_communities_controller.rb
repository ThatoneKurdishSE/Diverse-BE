class UserCommunitiesController < ApplicationController

  def all_user_communities
    UserCommunity.all
  end

  def find_by_id
    UserCommunity.find(params[:id])
  end

  def get_user
    User.find(@user_community[:user_id])
  end

  def get_community
    Community.find(@user_community[:community_id])
  end

  def unable_to_locate_user_community
    render json: { message: "Unable to locate referenced user community."}
  end

  def index
    @user_communities = all_user_communities
    render json: @user_communities, includes: %i[users communities]
  end

  def show
    @user_community = find_by_id
    if @user_community
      render json: @user_community, includes: %i[users communities]
    else
      unable_to_locate_user_community
  end

  def create
    @user = User.find_by(id: user_community_params[:user_id])
    @community = Community.find_by(id: user_community_params[:community_id])

    if @user && @community
      @user_community = UserCommunity.new(user_community_params)
      if @user_community.valid?
        @user_community.save
        render json: @user_community, message: "#{@user.username} became a member of ##{@community.name}."
      else
        render json: { errors: @user_community.errors.full_messages }, status: :unprocessable_entity
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

  def user_community_params
    params.require(:user_community).permit :user_id, :community_id
  end

  def destroy
    @user_community = find_by_id
    if @user_community
      @user_community.destroy
      render json: "Removed #{get_user.username} from ##{get_community.name}."
    else
      unable_to_locate_user_community
    end
  end
end
