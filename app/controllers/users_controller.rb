class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :login, :index, :show]

  def all_users
    User.all
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
    @user = User.new(params[:id])

    render json: @user, includes: :communities
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

  def search
    search_username = params[:search_criteria].downcase
    
    @search_results = all_users.filter { |user| user.username.downcase.include? search_username }
    if @search_results.length > 0
      render json: @search_results
    else
      render json: all_users, message: "No results found, please try searching something else."
    end
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end

  def user_params
    params.require(:user).permit(:username, :age, :email, :password)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    render json: "Destroyed #{@user}"
  end
end
