class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    
    def index
        users = User.all
        render json: users
    end

    def create
        user = User.create(user_params)
        if user.valid?
          Planner.create(user_id: user.id)
          payload = {user_id: user.id}
          token = encode_token(payload)
          render json: {user:user, jwt: token}
        else
          render json: {errors: user.errors.full_messages}, status: :not_acceptable
        end
    end

    def update
        user = User.find(params[:id])
        if user.update_attributes(user_params)
            render json: user
        else
            render json: {"message": "Something went wrong!"}
        end
    end

    def destroy
        user = User.find(params[:id])
        if user.destroy
            render json: user
        else
            render json: {"message": "Couldn't delete user."}
        end
    end

    private
    
    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
