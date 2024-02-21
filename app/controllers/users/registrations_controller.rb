# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    # before_action :configure_sign_up_params, only: [:create]
    # before_action :configure_account_update_params, only: [:update]
    before_action :append_group_and_username_and_email_unsubscribe_token, :configure_sign_up_params, only: [:create]
    include RackSessionsFix
    respond_to :json

    private

    def respond_with(current_user, _opts={})
      if resource.persisted?
        WelcomeMailer.welcome_email(current_user.email, current_user.username).deliver_later
        render json: {
          status: {code: 200, message: "Signed up successfully."},
          data:   UserSerializer.new(current_user).serializable_hash[:data][:attributes]
        }
      else
        render json: {
          status: {message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"}
        }, status: :unprocessable_entity
      end
    end

    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[email password group username email_unsubscribe_token])
    end

    def append_group_and_username_and_email_unsubscribe_token
      params[:user][:group] = determine_group
      params[:user][:username] = generate_username
      params[:user][:email_unsubscribe_token] = generate_email_unsubscribe_token
    end

    def determine_group
      pre_authorized_email = PreAuthorizedEmail.find_by(["lower(email) = ?", params[:user][:email]])
      return if pre_authorized_email.nil?

      pre_authorized_email.group
    end

    def generate_username
      loop do
        username = "#{Faker::Color.color_name.capitalize}#{Faker::Creature::Animal.name.capitalize}"
        break username unless User.exists?(username:)
      end
    end
    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    # def create
    #   super
    # end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_up_params
    #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    # end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
