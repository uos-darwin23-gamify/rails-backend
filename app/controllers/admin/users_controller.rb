module Admin
  class UsersController < ApplicationController
    before_action :authorize_admin_controllers
    before_action :set_user, only: [:destroy, :promote_to_admin]

    def all_users
      users = User.all.as_json(only: %i[id username group email])
      render json: users
    end

    def destroy
      old_group_is_admin = @user.admin_group?
      old_group_is_league = @user.league?
      @user.destroy

      if !old_group_is_admin && old_group_is_league
        update_league_leaderboard
      elsif !old_group_is_admin
        update_global_leaderboard
      end

      render json: {message: "User deleted successfully"}
    end

    def promote_to_admin
      render json: {message: "User is already an admin"} if @user.admin_group?

      old_group_is_league = @user.league?

      @user.update(user_type: User.user_types[:admin])
      @user.update(group: User.groups[:admin_group])

      if old_group_is_league
        update_league_leaderboard
      else
        update_global_leaderboard
      end

      render json: {message: "User promoted to admin successfully"}
    end

    private

    def set_user
      if params[:id].to_i.to_s == params[:id].to_s
        @user = User.find(params[:id])
        render json: {message: 'User not found'}, status: :not_found unless @user
      else
        render json: {message: 'Invalid ID parameter'}, status: :bad_request
      end
    end
  end
end
