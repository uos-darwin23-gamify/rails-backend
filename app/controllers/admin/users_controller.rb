module Admin
    class UsersController < ApplicationController
        before_action :authorize_admin_controllers


        def all_users
            users = User.all
            render json: users
        end

        def destroy
            @user = User.find(params[:id])
            @user.destroy
            render json: {message: "User deleted"}
        end

        def promote_to_admin
            @user = User.find(params[:id])
            @user.update(user_type: 1)
            @user.update(group: 99)
        end

    end
end
