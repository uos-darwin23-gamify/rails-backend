# frozen_string_literal: true

module Users
  class SettingsController < ApplicationController
    before_action :authorize_user_controllers

    def change_password
      challenge_oid = params[:id]

      request_current_user = current_user
      return render_internal_server_error if request_current_user.nil?


      change_successful = true

      return render json: {message: "Not Authorized"}, status: :unauthorized unless change_successful

      render json: {message: "OK"}
    end
  end
end
