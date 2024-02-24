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

  def generate_email_unsubscribe_token
    token = SecureRandom.hex(30)
    loop do
      token = SecureRandom.hex(30)
      break unless User.exists?(email_unsubscribe_token: token)
    end
    token
  end

  def give_min_score_for_challenge_if_no_solution(user, challenge)
    existing_solution = Solution.find_by(user_email: user.email, challenge_oid: challenge.id)

    if existing_solution.nil?
      new_elo = calculate_new_elo(user, challenge, 0)
      elo_change = new_elo - user.elo
      user.update(elo: [new_elo, 0].max)
      Solution.create!(
        user_email:     user.email,
        challenge_oid:  challenge.id,
        answer_correct: false,
        new_elo:, elo_change:
      )
    elsif existing_solution&.answer_correct.nil?
      new_elo = calculate_new_elo(user, challenge, 0)
      elo_change = new_elo - user.elo
      user.update(elo: [new_elo, 0].max)
      existing_solution.update(answer_correct: false,
                               new_elo:, elo_change:)
    end
  end

  def calculate_new_elo(user, challenge, result)
    difficulty_gap = challenge.difficulty_level.to_f - user.elo.to_f
    expected_score = 1.0 / (1.0 + (10.0**(difficulty_gap / Constants::SCALING_FACTOR.to_f)))
    actual_score = result.to_f
    adjustment_factor = challenge.adjustment_factor.to_f

    new_elo = user.elo.to_f + (adjustment_factor * (actual_score - expected_score))
    new_elo.round
  end
end
