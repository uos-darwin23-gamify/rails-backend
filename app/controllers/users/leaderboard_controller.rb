# frozen_string_literal: true

module Users
  class LeaderboardController < ApplicationController
    before_action :authorize_user_controllers

    def avatar_dropdown_info
      user = current_user

      unless user.league? || user.global?
        return render json: {message: "Not Authorized"}, status: :unauthorized
      end

      stats = nil

      if placement_challenges_finished(user)
        if user.league?
          latest_entry = LeagueLeaderboard.latest_entry

          leaderboard = latest_entry.leaderboard

          user_league = leaderboard.find {|entry| entry["username"] == user.username }&.[](:league)
          return render_internal_server_error if user_league.nil?

          user_league_all = leaderboard.filter {|entry| entry["league"] == user_league }
          user_position = user_league_all.find_index {|entry| entry["username"] == user.username } + 1
          total_players_in_league = user_league_all.size

          stats = {elo: user.elo, user_league: user_league.capitalize, user_position:, total_players_in_league:}
        elsif user.global?
          latest_entry = GlobalLeaderboard.latest_entry

          leaderboard = latest_entry.leaderboard

          user_position = leaderboard.find_index {|entry| entry["username"] == user.username } + 1
          total_players = leaderboard.size

          stats = {elo: user.elo, user_position:, total_players:}
        end
      end

      render json: {username: user.username, group: user.group,
placement_challenges_finished: placement_challenges_finished(user), stats: stats}
    end

    def leaderboard
      user = current_user

      unless user.league? || user.global?
        return render json: {group: user.group}
      end

      stats = nil

      if placement_challenges_finished(user)
        if user.league?
          latest_entry = LeagueLeaderboard.latest_entry
          unlocked_leagues = latest_entry.unlocked_leagues
          leaderboard = latest_entry.leaderboard

          user_league = leaderboard.find {|entry| entry["username"] == user.username }&.[](:league)
          return render_internal_server_error if user_league.nil?

          user_league_all = leaderboard.filter {|entry| entry["league"] == user_league }
          user_position = user_league_all.find_index {|entry| entry["username"] == user.username } + 1
          total_players_in_league = user_league_all.size

          user_league_index = unlocked_leagues.find_index(user_league)
          preceding_league = user_league_index > 0 ? unlocked_leagues[user_league_index - 1] : user_league
          succeeding_league = user_league_index < unlocked_leagues.length - 1 ? unlocked_leagues[user_league_index + 1] : user_league

          # neighbouring_leagues = [preceding_league, user_league, succeeding_league].map(&:capitalize)
          neighbouring_leagues = [preceding_league, user_league, succeeding_league]

          preceding_league_highest_elo_player = nil
          succeeding_league_lowest_elo_player = nil

          if preceding_league != user_league
            preceding_league_players = leaderboard.filter {|entry| entry["league"] == preceding_league }
            preceding_league_highest_elo_player = preceding_league_players.max_by {|entry|
              entry["elo"]
            }&.[](:elo) unless preceding_league_players.empty?
          end

          if succeeding_league != user_league
            succeeding_league_players = leaderboard.filter {|entry| entry["league"] == succeeding_league }
            succeeding_league_lowest_elo_player = succeeding_league_players.min_by {|entry|
              entry["elo"]
            }&.[](:elo) unless succeeding_league_players.empty?
          end

          stats = {elo: user.elo, user_league: user_league, user_position:, total_players_in_league:,
league_state: user_league_all, neighbouring_leagues:, preceding_league_highest_elo_player:, succeeding_league_lowest_elo_player:}
        elsif user.global?
          latest_entry = GlobalLeaderboard.latest_entry

          leaderboard = latest_entry.leaderboard

          user_position = leaderboard.find_index {|entry| entry["username"] == user.username } + 1
          total_players = leaderboard.size

          stats = {elo: user.elo, user_position:, total_players:, leaderboard_state: leaderboard}
        end
      end

      render json: {username: user.username, group: user.group,
placement_challenges_finished: placement_challenges_finished(user), stats: stats}
    end
  end
end
