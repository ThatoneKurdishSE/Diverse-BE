class UsersController < ApplicationController

    def index 
        @users = User.all

        render json: @users
    end

    def show
        @user = User.find(params[:id])

        render json: @user, includes: :communities
    end

    def create
        @user = User.create(user_params)

        render json: @user, message: "User Created!"
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end

end
