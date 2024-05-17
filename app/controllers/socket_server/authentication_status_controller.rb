# frozen_string_literal: true

module SocketServer
  class AuthenticationStatusController < ApplicationController
    before_action :authorize_socket_server_controllers

    def index
      user_type = authenticated_from_socket?

      if user_type
        user = current_user_from_socket
        render json: {userType: user_type, email: user.email}
      else
        render json: {userType: "Not Authenticated"}, status: :unauthorized
      end
    end
  end
end
