class CommunitiesController < ApplicationController

  def all_communities
    Community.all
  end

  def find_by_id
    Community.find(params[:id])
  end

  def index
    render json: all_communities
  end

  def unable_to_locate_community
    render json: { message: "Unable to locate referenced community."}
  end

  def show
    @community = find_by_id
    if @community
      render json: @community, includes: :users
    else
      unable_to_locate_community
    end
  end

  def create
    @community = Community.new(community_params)
    if @community.valid?
      @community.save
      render json: @community, message: "##{@community.name} created!"
    else
      render json: { errors: @community.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def search_by_name
    search_name = params[:search_criteria].downcase
    Community.where( 'name LIKE ?', "%#{search_name}%" )
  end

  def search
    if params[:search_criteria]
      @search_results = search_by_name
      if @search_results.length > 0
        render json: @search_results
      else
        render json: all_communities, message: "No results found, please try searching something else."
      end
    else
      render json: all_communities
    end
  end

  def community_members
    @community = find_by_id
    if @community
      render json: @community.users
    else
      unable_to_locate_community
    end
  end

  private

  def community_params
    params.require(:community).permit(:name, :location, :description)
  end

  def destroy
    @community = find_by_id
    if @community
      @community.destroy
      render json: "Deleted ##{@community.name}"
    else
      unable_to_locate_community
    end
  end
end
