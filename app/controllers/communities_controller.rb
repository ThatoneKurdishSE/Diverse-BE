class CommunitiesController < ApplicationController

  def all_communities
    Community.all
  end

  def index
    render json: all_communities
  end

  def show
    @community = Community.find(params[:id])

    render json: @community, includes: :users
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

  def search
    search_name = params[:search_criteria].downcase
    
    @search_results = all_communities.filter { |community| community.name.downcase.include? search_name }
    if @search_results.length > 0
      render json: @search_results
    else
      render json: @all_communities, message: "No results found, please try searching something else."
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
