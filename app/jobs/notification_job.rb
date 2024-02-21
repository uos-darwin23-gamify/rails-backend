# frozen_string_literal: true

class NotificationJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    NotificationMailer.notification_to_all.deliver_later
  rescue StandardError => e
    Rails.logger.error "Failed to send notification email: #{e.message}"
  end
end
