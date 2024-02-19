# frozen_string_literal: true

module Users
  class ConsentController < ApplicationController
    # before_action :authenticate_user!, only: [:submit_consent]
    # before_action :authenticate_user!
    before_action :authorize_user_controllers

    def consent
      user = current_user

      return render json: {status: "error", data: "User not found"}, status: :not_found unless user

      render json: {consent: user.consent}
    end

    def submit_consent
      user = current_user

      if user
        user.update_attribute(:consent, true)
        render json: {status: "success"}
      else
        render json: {status: "error", data: "User not found"}, status: :not_found
      end
    end
  end
end
