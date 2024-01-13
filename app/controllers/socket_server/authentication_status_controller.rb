# frozen_string_literal: true

module SocketServer
  class AuthenticationStatusController < ApplicationController
    def index
      user_type = authenticated_from_socket?

      if authenticated_from_socket?
        render json: {userType: user_type}
      else
        render json: {userType: "Not Authenticated"}, status: :unauthorized
      end
    end
  end
end
