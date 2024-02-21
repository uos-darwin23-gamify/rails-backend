# frozen_string_literal: true

module Users
  class SettingsController < ApplicationController
    before_action :authorize_user_controllers

    def change_password
      params[:id]

      user = current_user
      return render_internal_server_error if user.nil?

      if params[:currentPassword].nil? || params[:newPassword].nil? || params[:confirmNewPassword].nil?
        return render_bad_request
      end

      user_params = {
        password:              params[:newPassword],
        password_confirmation: params[:confirmNewPassword],
        current_password:      params[:currentPassword]
      }

      unless user.update_with_password(user_params)
        return render json: {message: "Not Authorized"}, status: :unauthorized
      end

      bypass_sign_in(user)
      render json: {message: "OK"}
    end

    def email_notifications_setting
      user = current_user
      return render_internal_server_error if user.nil?

      render json: {email_notifications_setting: user.email_notifications}
    end

    def change_email_notifications_setting
      user = current_user
      return render_internal_server_error if user.nil?

      new_setting = params[:email_notifications_setting]

      return render_bad_request if new_setting.nil?

      return render_bad_request unless new_setting.is_a?(TrueClass) || new_setting.is_a?(FalseClass)

      user.update_attribute(:email_notifications, new_setting)
      render json: {message: "OK"}
    end

    def unsubscribe
      token = params[:token]

      return redirect_to "/unsubscribe/failure" if token.nil?

      user = User.find_by(email_unsubscribe_token: token)

      return redirect_to "/unsubscribe/failure" if user.nil?

      return redirect_to "/unsubscribe/failure" if token != user.email_unsubscribe_token

      user.update_attribute(:email_notifications, false)
      user.update_attribute(:email_unsubscribe_token, generate_email_unsubscribe_token)

      redirect_to "/unsubscribe/success"
    end
  end
end
