# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_cookie_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  enum user_type: {user: 0, admin: 1}
  validates :user_type, presence: true, inclusion: {in: User.user_types.keys}

  EMAIL_REGEX = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/
  validates :email, presence: true, format: {with: EMAIL_REGEX}

  validate :email_in_pre_authorized_emails

  private

  def email_in_pre_authorized_emails
    return if PreAuthorizedEmail.exists?(["lower(email) = ?", email.downcase])

    errors.add(:email, "is not pre-authorized")
  end
end
