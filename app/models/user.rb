# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :jwt_cookie_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  enum user_type: {user: 0, admin: 1}
  enum group: {league: 0, global: 1, admin_group: 99}
  validates :user_type, presence: true, inclusion: {in: User.user_types.keys}
  validates :group, presence: true, inclusion: {in: User.groups.keys}

  EMAIL_REGEX = /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\z/
  validates :email, presence: true, format: {with: EMAIL_REGEX}

  validate :email_in_pre_authorized_emails

  has_many :solutions, foreign_key: "user_email", primary_key: "email"

  def self.all_in_league_group
    where(group: User.groups[:league])
  end

  def self.all_in_global_group
    where(group: User.groups[:global])
  end

  def admin_group?
    group == "admin_group"
  end

  def league?
    group == "league"
  end

  def global?
    group == "global"
  end

  private

  def email_in_pre_authorized_emails
    return if PreAuthorizedEmail.exists?(["lower(email) = ?", email.downcase])

    errors.add(:email, "is not pre-authorized")
  end
end
