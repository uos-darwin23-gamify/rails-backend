class NotificationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    begin
      NotificationMailer.notification_to_all().deliver_now
    rescue => e
      Rails.logger.error "Failed to send notification email: #{e.message}"
    end
  end
  
end
