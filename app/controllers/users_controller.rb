class UsersController < ApplicationController

  skip_before_action :authorized, only: [:create, :login, :index, :show]

  def login
    @user = User.find_by({ name: params[:name] })
    if !@user
      render json: { error: 'Incorrect User/Password' }, status: :unauthorized
    elsif !@user.authenticate(params[:password])
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
    @users = User.all

    render json: @users
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

  private

  def user_params
    params.require(:user).permit(:username, :age, :email, :password)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    render json: "Destroyed #{@user}"
  end
end
