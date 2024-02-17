class Users::ConsentController < ApplicationController
  # before_action :authenticate_user!, only: [:submit_consent]
  before_action :authenticate_user!

  def submit_consent
    @user = current_user

    if @user
      @user.update_attribute(:consent, true)
      render json: {status: "success", data: @user}, status: :ok
    else
      render json: {status: "error", data: "User not found"}, status: :not_found
    end
  end
end
