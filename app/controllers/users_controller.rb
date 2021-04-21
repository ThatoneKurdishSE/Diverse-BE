class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :login, :index, :show]

  def all_users
    User.all
  end

  def find_by_id
    User.find(params[:id])
  end

  def login
    @user = User.find_by({ username: login_params[:username] })
    if !@user
      render json: { error: 'Incorrect User/Password' }, status: :unauthorized
    elsif !@user.authenticate(login_params[:password])
      render json: { error: 'Incorrect User/Password' }, status: :unauthorized
    else
      payload = {
        user_id: @user.id
      }
      secret = Rails.application.secrets.secret_key_base[0]
      token = JWT.encode(payload, secret)
      render json: { token: token }, status: :created
    end
  end

  def index
    render json: all_users
  end

  def show
    render json: find_by_id, includes: :communities
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      render json: @user, message: 'User Created!'
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def profile
    render json: @user
  end

  def search_by_username
    search_username = params[:search_criteria].downcase
    User.where( 'username LIKE ?', "%#{search_username}%")
  end

  def search
    if params[:search_criteria]
      @search_results = search_by_username
      if @search_results.length > 0
        render json: @search_results
      else
        render json: all_users, message: "No results found, please try searching something else."
      end
    else
      render json: all_users
    end
  end

  def user_communities
    @user = find_by_id
    render json: @user.communities
  end 

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end

  def user_params
    params.require(:user).permit(:username, :age, :email, :password)
  end

  def destroy
    @user = find_by_id
    @user.destroy

    render json: "Destroyed #{@user}"
  end
end
