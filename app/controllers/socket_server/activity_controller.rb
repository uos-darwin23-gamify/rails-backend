# frozen_string_literal: true

module SocketServer
  class ActivityController < ApplicationController
    before_action :authorize_socket_server_controllers

    def connect
      user_type = authenticated_from_socket?

      return render json: {message: "Not Authenticated"}, status: :unauthorized unless user_type

      if user_type != "user"
        return render json: {message: "Only user activity can be registered"}, status: :unauthorized
      end

      user = current_user_from_socket

      email = user.email
      username = user.username
      group = user.group
      elo_session_start = user.elo
      placement_challenges_finished_session_start = placement_challenges_finished(user)

      last_activity = Activity.where(email:)&.order(start_time: :desc)&.first

      if last_activity && !last_activity.end_time.nil? && Time.zone.now - last_activity.end_time < Constants::MINIMUM_INTERVAL_BETWEEN_UNIQUE_ACTIVITY_SESSIONS_SECONDS
        last_activity.update!(
          end_time:                                  nil,
          session_duration_seconds:                  nil,
          elo_session_end:                           nil,
          placement_challenges_finished_session_end: nil
        )

        return render json: {message: "OK"}
      end

      if last_activity && last_activity.end_time.nil? && Time.zone.now - last_activity.start_time < Constants::MINIMUM_INTERVAL_BETWEEN_UNIQUE_ACTIVITY_SESSIONS_SECONDS
        return render json: {message: "OK"}
      end

      Activity.create!(
        email:,
        username:,
        group:,
        elo_session_start:,
        placement_challenges_finished_session_start:
      )

      render json: {message: "OK"}
    end

    def disconnect
      user_type = authenticated_from_socket?

      return render json: {message: "Not Authenticated"}, status: :unauthorized unless user_type

      if user_type != "user"
        return render json: {message: "Only user activity can be registered"}, status: :unauthorized
      end

      user = current_user_from_socket

      last_activity = Activity.where(email: user.email)&.order(start_time: :desc)&.first

      return render json: {message: "OK"} if last_activity.nil?

      return render json: {message: "OK"} if last_activity && !last_activity.end_time.nil?

      last_activity.update!(
        end_time:                                  Time.zone.now,
        session_duration_seconds:                  Time.zone.now - last_activity.start_time,
        elo_session_end:                           user.elo,
        placement_challenges_finished_session_end: placement_challenges_finished(user)
      )

      render json: {message: "OK"}
    end
  end
end
