# frozen_string_literal: true

module Users
  class AuthenticationStatusController < ApplicationController
    def index
      user_type = authenticated?

      if authenticated?
        render json: {userType: user_type}
      else
        render json: {userType: "Not Authenticated"}, status: :unauthorized
      end
    end

    def info
      return {message: "Not Authorized"}, status: :unauthorized unless authenticated?

      user = current_user

      render json: {username: user.username, group: user.group}
    end
  end
end
