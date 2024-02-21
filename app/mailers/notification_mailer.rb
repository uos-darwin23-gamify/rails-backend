# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: "No Reply - GamifyCoding\u2122 <no-reply@gamifycoding.me>"

  # Method to send notification to all user email addresses
  def notification_to_all
    users = User.all

    # Check if there are any email addresses
    if users.exists?
      users.find_each do |user|
        mail(to: user.email, subject: "Your Daily Notifications - GamifyCoding\u2122") do |format|
          format.html { render "notification", locals: {email: user.email} }
        end.deliver
      end
    else
      # Log an error or take other actions if no email addresses are found
      Rails.logger.error "No pre-authorized email addresses found for notification."
      # Additional error handling actions can be placed here
    end
  end
end
