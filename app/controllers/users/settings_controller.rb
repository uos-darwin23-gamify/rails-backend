# frozen_string_literal: true

module Users
  class SettingsController < ApplicationController
    before_action :authorize_user_controllers

    def change_password
      challenge_oid = params[:id]

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

      if user.update_with_password(user_params)
        bypass_sign_in(user)
        return render json: {message: "OK"}
      else
        return render json: {message: "Not Authorized"}, status: :unauthorized
      end
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

      if new_setting.nil?
        return render_bad_request
      end

      unless new_setting.is_a?(TrueClass) || new_setting.is_a?(FalseClass)
        return render_bad_request
      end

      user.update_attribute(:email_notifications, new_setting)
      return render json: {message: "OK"}
    end

    def unsubscribe
      token = params[:token]

      if token.nil?
        return redirect_to "/unsubscribe/failure"
      end

      user = User.find_by(email_unsubscribe_token: token)

      if user.nil?
        return redirect_to "/unsubscribe/failure"
      end

      if token != user.email_unsubscribe_token
        return redirect_to "/unsubscribe/failure"
      end

      user.update_attribute(:email_notifications, false)
      user.update_attribute(:email_unsubscribe_token, generate_email_unsubscribe_token)

      return redirect_to "/unsubscribe/success"
    end
  end
end
