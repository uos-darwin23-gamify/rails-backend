module ApplicationHelper
    def current_user
        return false if cookies[:access_token].blank?

        jwt_payload = JWT.decode(cookies[:access_token], Rails.application.credentials.devise_jwt_secret_key!).first
        current_user = User.find(jwt_payload["sub"])

        return false unless current_user

        current_user
    end
end