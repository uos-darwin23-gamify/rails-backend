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
          elo_difference:                            nil,
          placement_challenges_finished_session_end: nil,
          league_session_end:                        nil,
          league_position_session_end:               nil,
          league_size_session_end:                   nil,
          global_position_session_end:               nil,
          global_leaderboard_size_session_end:       nil,
        )

        return render json: {message: "OK"}
      end

      if last_activity && last_activity.end_time.nil? && Time.zone.now - last_activity.start_time < Constants::MINIMUM_INTERVAL_BETWEEN_UNIQUE_ACTIVITY_SESSIONS_SECONDS
        return render json: {message: "OK"}
      end

      if user.group == "league"
        if placement_challenges_finished_session_start
          latest_entry = LeagueLeaderboard.latest_entry
          unlocked_leagues = latest_entry.unlocked_leagues
          leaderboard = latest_entry.leaderboard
          user_league = leaderboard.find {|entry| entry["username"] == user.username }&.[](:league)
          user_league_all = leaderboard.filter {|entry| entry["league"] == user_league }
          user_position = user_league_all.find_index {|entry| entry["username"] == user.username } + 1
          total_players_in_league = user_league_all.size

          Activity.create!(
            email:,
            username:,
            group:,
            elo_session_start:,
            placement_challenges_finished_session_start:,

            league_session_start:                        user_league,
            league_position_session_start:               user_position,
            league_size_session_start:                   total_players_in_league
          )
        else
          Activity.create!(
            email:,
            username:,
            group:,
            elo_session_start:,
            placement_challenges_finished_session_start:
          )
        end

      elsif user.group == "global"
        if placement_challenges_finished_session_start
          latest_entry = GlobalLeaderboard.latest_entry
          leaderboard = latest_entry.leaderboard
          user_position = leaderboard.find_index {|entry| entry["username"] == user.username } + 1
          total_players = leaderboard.size

          Activity.create!(
            email:,
            username:,
            group:,
            elo_session_start:,
            placement_challenges_finished_session_start:,

            global_position_session_start:               user_position,
            global_leaderboard_size_session_start:       total_players,
          )
        else
          Activity.create!(
            email:,
            username:,
            group:,
            elo_session_start:,
            placement_challenges_finished_session_start:
          )
        end
      end

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

      placement_challenges_finished_session_end = placement_challenges_finished(user)

      if user.group == "league"
        if placement_challenges_finished_session_end
          latest_entry = LeagueLeaderboard.latest_entry
          unlocked_leagues = latest_entry.unlocked_leagues
          leaderboard = latest_entry.leaderboard
          user_league = leaderboard.find {|entry| entry["username"] == user.username }&.[](:league)
          user_league_all = leaderboard.filter {|entry| entry["league"] == user_league }
          user_position = user_league_all.find_index {|entry| entry["username"] == user.username } + 1
          total_players_in_league = user_league_all.size

          last_activity.update!(
            end_time:                                  Time.zone.now,
            session_duration_seconds:                  Time.zone.now - last_activity.start_time,
            elo_session_end:                           user.elo,
            elo_difference:                            user.elo - last_activity.elo_session_start,
            placement_challenges_finished_session_end: placement_challenges_finished(user),

            league_session_end:                        user_league,
            league_position_session_end:               user_position,
            league_size_session_end:                   total_players_in_league,
          )
        else
          last_activity.update!(
            end_time:                                  Time.zone.now,
            session_duration_seconds:                  Time.zone.now - last_activity.start_time,
            elo_session_end:                           user.elo,
            elo_difference:                            user.elo - last_activity.elo_session_start,
            placement_challenges_finished_session_end: placement_challenges_finished(user)
          )
        end
      elsif user.group == "global"
        if placement_challenges_finished_session_end
          latest_entry = GlobalLeaderboard.latest_entry
          leaderboard = latest_entry.leaderboard
          user_position = leaderboard.find_index {|entry| entry["username"] == user.username } + 1
          total_players = leaderboard.size

          last_activity.update!(
            end_time:                                  Time.zone.now,
            session_duration_seconds:                  Time.zone.now - last_activity.start_time,
            elo_session_end:                           user.elo,
            elo_difference:                            user.elo - last_activity.elo_session_start,
            placement_challenges_finished_session_end: placement_challenges_finished(user),

            global_position_session_end:               user_position,
            global_leaderboard_size_session_end:       total_players,
          )
        else
          last_activity.update!(
            end_time:                                  Time.zone.now,
            session_duration_seconds:                  Time.zone.now - last_activity.start_time,
            elo_session_end:                           user.elo,
            elo_difference:                            user.elo - last_activity.elo_session_start,
            placement_challenges_finished_session_end: placement_challenges_finished(user)
          )
        end
      end

      render json: {message: "OK"}
    end
  end
end
