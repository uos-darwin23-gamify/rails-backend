# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: "No Reply - GamifyCoding\u2122 <no-reply@gamifycoding.me>"

  # Method to send notification to all user email addresses (where email_notifications == true)
  def notification_to_all
    users = User.where(email_notifications: true)
    @current_challenges = Challenge.all
    # Check if there are any email addresses
    if users.exists?
      users.find_each do |user|
        if user.user_type != "admin"
          @username = user.username
          @elo = user.elo          
          if user.group == "league" && user.league?
            latest_entry = LeagueLeaderboard.latest_entry
    
            if latest_entry.nil?
              Rails.logger.error "No latest entry found for LeagueLeaderboard."
              # You might want to skip this user or handle this scenario appropriately.
              @currentLeague = "not currently placed in a league. Complete the placement challenges to get a league"
            end
    
            leaderboard = latest_entry.leaderboard
    
            user_league = leaderboard.find { |entry| entry["username"] == user.username }&.[](:league)
            if user_league.nil?
              Rails.logger.error "User league not found in leaderboard."
              @currentLeague = "not currently placed in a league. Complete the placement challenges to get a league"
              @currentPos = "0"
              @leaderboard = "league"
            else
              user_league_all = leaderboard.filter { |entry| entry["league"] == user_league }
              user_position = user_league_all.find_index { |entry| entry["username"] == user.username } + 1
      
              @currentLeague = user_league.capitalize
              @currentPos = user_position
              @leaderboard = "league"
            end
    
           
          else
            latest_entry = GlobalLeaderboard.latest_entry

            leaderboard = latest_entry.leaderboard

            @currentPos = leaderboard.find_index {|entry| entry["username"] == user.username } + 1
            @total_players = leaderboard.size
            @leaderboard = "global"  # Or any other appropriate value based on your application logic
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
      # Log an error or take other actions if no email addresse s are found
      Rails.logger.error "No email addresses found for notification."
      # Additional error handling actions can be placed here
    end
  end
end
