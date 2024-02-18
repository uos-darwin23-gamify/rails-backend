# frozen_string_literal: true

module ApplicationHelper
  def authenticated?
    user = current_user

    return false unless user

    user.user_type
  end

  def authenticated_from_socket?
    user = current_user_from_socket

    return false unless user

    user.user_type
  end

  def current_user
    return false if cookies[:access_token].blank?

    jwt_payload = JWT.decode(cookies[:access_token], Rails.application.credentials.devise_jwt_secret_key!).first
    current_user = User.find(jwt_payload["sub"])

    return false unless current_user

    current_user
  end

  def current_user_from_socket
    return false if params[:access_token].blank?

    jwt_payload = JWT.decode(params[:access_token], Rails.application.credentials.devise_jwt_secret_key!).first
    current_user = User.find(jwt_payload["sub"])

    return false unless current_user

    current_user
  end

  def user_type?
    user = current_user

    return false if !user || user.user_type != "user"

    true
  end

  def admin_type?
    user = current_user

    return false if !user || user.user_type != "admin"

    true
  end

  def authorize_admin_controllers
    render json: {message: "Not Authorized"}, status: :unauthorized unless admin_type?
  end

  def authorize_user_controllers
    render json: {message: "Not Authorized"}, status: :unauthorized unless user_type?
  end

  def authorize_socket_server_controllers
    return if params[:API_KEY] == Rails.application.credentials.socket_server_api_key!

    render json:   {message: "Not Authorized"},
           status: :unauthorized
  end

  def render_bad_request
    render json: {message: "Bad request"}, status: :bad_request
  end

  def render_internal_server_error
    render json: {message: "Internal server error"}, status: :internal_server_error
  end
end
