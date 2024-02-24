require "#{Rails.root}/app/helpers/application_helper"

include ApplicationHelper

namespace :cron do
    desc "Send daily notification to all user email addresses (where email_notifications == true)"
    task notification_to_all: :environment do
        NotificationMailer.notification_to_all.deliver
        rescue StandardError => e
            Rails.logger.error "Failed to send notification email: #{e.message}"
    end

    desc "Give minimum score for past challenges to all users that haven't submitted solutions"
    task give_min_score_for_past_challenges_where_no_solution: :environment do
      begin
        User.all.each do |user|
          total_elo_change = 0
          Challenge.available_in_past.each do |challenge|
            total_elo_change += give_min_score_for_challenge_if_no_solution(user, challenge)
          end
          user_elo = user.elo
          user.update(elo: [user_elo + total_elo_change, 0].max)
        end
      rescue StandardError => e
        Rails.logger.error "Failed to update scores: #{e.message}"
      end
    end
  end