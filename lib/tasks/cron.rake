namespace :cron do
    desc "Send daily notification to all user email addresses (where email_notifications == true)"
    task notification_to_all: :environment do
        NotificationMailer.notification_to_all.deliver
        rescue StandardError => e
            Rails.logger.error "Failed to send notification email: #{e.message}"
    end
  end