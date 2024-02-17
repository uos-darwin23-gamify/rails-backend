module Users
  class PasswordsController < Devise::PasswordsController
    def email_exists
      user = User.find_by(email: params[:email])
      render json: { exists: user.present? }
    end
  end
end