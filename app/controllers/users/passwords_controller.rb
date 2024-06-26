# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    def resource_params
      params.require(:user).permit(:email).merge(redirect_url: params[:redirect_url])
    end

    def edit
      raw_token = params[:reset_password_token]
      encrypted_token = Devise.token_generator.digest(User, :reset_password_token, raw_token)
      user = User.find_by(reset_password_token: encrypted_token)

      if user.present?
        if params[:redirect_url].present?
          # Rails.logger.debug { "Redirecting to #{params[:redirect_url]}?reset-password-token=#{raw_token}" }
          redirect_to "#{params[:redirect_url]}?reset-password-token=#{raw_token}"
        else
          render json: {error: "Redirect URL not provided"}, status: :unprocessable_entity
        end
      else
        render json: {error: "Invalid reset password token"}, status: :unprocessable_entity
      end
    end

    # POST /resource/password
    def create
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
      else
        respond_with(resource)
      end
    end

    def update
      @user = find_user_by_token

      if @user.present? && @user.reset_password_period_valid?
        reset_password
      else
        render json: {error: "Invalid reset password token"}, status: :unprocessable_entity
      end
    end

    private

    def find_user_by_token
      raw_token = params[:reset_password_token]
      encrypted_token = Devise.token_generator.digest(User, :reset_password_token, raw_token)
      User.find_by(reset_password_token: encrypted_token)
    end

    def reset_password
      @user.reset_password(params[:password], params[:password_confirmation])
      if @user.errors.empty?
        render json: {message: "Password reset successful"}, status: :ok
      else
        render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
      end
    end

    # Check if email exists
    def email_exists
      user = User.find_by(email: params[:email])
      render json: {exists: user.present?}
    end
  end
end
