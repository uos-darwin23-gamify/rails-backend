# frozen_string_literal: true

class WelcomeMailer < ApplicationMailer
  default from: "No Reply - GamifyCoding\u2122 <no-reply@gamifycoding.me>"

  # Method to send notification to all pre-authorized email addresses
  def welcome_email(email, username)
    @username = username
    begin
      mail(to: email, subject: "Welcome To GamifyCoding\u2122") do |format|
        format.html { render "welcome" }
      end.deliver
    rescue StandardError => e
      Rails.logger.error "Failed to send welcome email: #{e.message}"
    end
  end
end
