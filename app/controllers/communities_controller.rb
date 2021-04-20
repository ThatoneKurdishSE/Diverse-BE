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

  def show
    render json: find_by_id, includes: :users
  end

  def create
    @community = Community.new(community_params)
    if @community.valid?
      @community.save
      render json: @community, message: 'Community Created!'
    else
      render json: { errors: @community.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def search_by_name
    search_name = params[:search_criteria].downcase
    all_communities.filter { |community| community.name.downcase.include? search_name }
  end

  def search
    @search_results = search_by_name
    if @search_results.length > 0
      render json: @search_results
    else
      render json: all_communities, message: "No results found, please try searching something else."
    end
  end

  def community_members
    @community = find_by_id
    render json: @community.users
  end

  private

  def community_params
    params.require(:community).permit(:name, :location, :description)
  end

  def destroy
    @community = find_by_id
    @community.destroy
    render json: "Destroyed #{@community}"
  end
end
