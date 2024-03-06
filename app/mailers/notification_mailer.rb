# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: "No Reply - GamifyCoding\u2122 <no-reply@gamifycoding.me>"

  # Method to send notification to all user email addresses (where email_notifications == true)
  def notification_to_all
    users = User.where(email_notifications: true)

    difficulty_order = {
      "SIMPLE"  => 0,
      "EASY"    => 1,
      "MEDIUM"  => 2,
      "HARD"    => 3,
      "EXTREME" => 4
    }

    # Check if there are any email addresses
    if users.exists?
      users.find_each do |user|
        if user.user_type != "admin"
          @current_challenges = if placement_challenges_finished(user)
                                  Challenge.available_today.sort_by {|challenge|
                                    difficulty_order[challenge.difficulty]
                                  }.to_a
                                else
                                  PlacementChallenge.all.sort_by {|challenge|
                                    difficulty_order[challenge.difficulty]
                                  }.to_a + Challenge.available_today.sort_by {|challenge|
                                             difficulty_order[challenge.difficulty]
                                           }.to_a
                                end
          @no_challenges_available_inherent = @current_challenges.empty?
          @current_challenges = @current_challenges.select do |challenge|
            @no_challenges_available_inherent = false
            solution = Solution.find_by(user_email: user.email, challenge_oid: challenge.id)
            solution.nil? || solution.answer_correct.nil?
          end

          @placement_challenges_finished = placement_challenges_finished(user)
          @username = user.username
          @elo = user.elo

          if user.league?
            @leaderboard = "league"
            if @placement_challenges_finished
              latest_entry = LeagueLeaderboard.latest_entry

              if latest_entry.nil?
                Rails.logger.error "No latest entry found for LeagueLeaderboard."
                next
                # You might want to skip this user or handle this scenario appropriately.
                # @currentLeague = "not currently placed in a league. Complete the placement challenges to get a league."
              end

              leaderboard = latest_entry.leaderboard

              user_league = leaderboard.find {|entry| entry["username"] == user.username }&.[](:league)

              if user_league.nil?
                Rails.logger.error "User league not found in leaderboard."
                # @currentLeague = "not currently placed in a league. Complete the placement challenges to get a league."
                # @currentPos = "0"
                next
              else
                user_league_all = leaderboard.filter {|entry| entry["league"] == user_league }
                user_position = user_league_all.find_index {|entry| entry["username"] == user.username } + 1
                @total_players_in_league = user_league_all.size
                @currentLeague = user_league.capitalize
                @currentPos = user_position
              end
            end
          else
            @leaderboard = "global"
            if @placement_challenges_finished
              latest_entry = GlobalLeaderboard.latest_entry

              if latest_entry.nil?
                Rails.logger.error "No latest entry found for GlobalLeaderboard."
                next
                # You might want to skip this user or handle this scenario appropriately.
                # @currentLeague = "not currently placed in a league. Complete the placement challenges to get a league."
              end

              leaderboard = latest_entry.leaderboard

              @currentPos = leaderboard.find_index {|entry| entry["username"] == user.username } + 1
              @total_players = leaderboard.size
              # @leaderboard = "global"  # Or any other appropriate value based on your application logic
            end
          end

          mail(to: user.email, subject: "Your Daily Notifications - GamifyCoding\u2122") do |format|
            headers["List-Unsubscribe-Post"] = "List-Unsubscribe=One-Click"
            headers["List-Unsubscribe"] = "<https://gamifycoding.me/api/unsubscribe?token=#{user.email_unsubscribe_token}>"
            @unsubscribe_token = user.email_unsubscribe_token
            format.html { render "notification", locals: {email: user.email} }
          end.deliver
        end
      end
    else
      # Log an error or take other actions if no email addresses are found
      Rails.logger.error "No email addresses found for notification."
      # Additional error handling actions can be placed here
    end
  end
end
