# frozen_string_literal: true

module Users
  class PasswordsController < Devise::PasswordsController
    def resource_params
      params.require(:user).permit(:email).merge(redirect_url: params[:redirect_url])
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

    # Check if email exists
    def email_exists
      user = User.find_by(email: params[:email])
      render json: {exists: user.present?}
    end
  end
end
