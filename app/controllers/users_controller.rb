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

    def login
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            secret = Rails.application.secret_key_base[0]
            @token = JWT.encode(payload, secret)

            render json: {user: @user, token: @token}
        else
            render json: {error: "Invalid Credentials"}, status: :unauthorized
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
