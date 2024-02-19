class NotificationMailer < ApplicationMailer
  default from: "no-reply@gamifycoding.me"

  # Method to send notification to all pre-authorized email addresses
  def notification_to_all
    users = User.all
    
    # Check if there are any email addresses
    if emails.exists?
      users.find_each do |user|
        mail(to: user.email, subject: "Your Daily Notification") do |format|
          format.html { render 'notification', locals: { email: user.email } }
        end.deliver
      end
    else
      # Log an error or take other actions if no email addresses are found
      Rails.logger.error "No pre-authorized email addresses found for notification."
      # Additional error handling actions can be placed here
    end
  end
end
