class UsersController < ApplicationController

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
            render json: @user, message: "User Created!"
        else
            render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end 
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password)
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy

        render json: "Destroyed #{@user}"
    end

end
