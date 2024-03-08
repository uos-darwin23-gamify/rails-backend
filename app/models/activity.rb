# frozen_string_literal: true

class Activity < ApplicationRecord
  self.table_name = "activities"

  enum group: {league: 0, global: 1, admin_group: 99}
  validates :group, presence: true, inclusion: {in: Activity.groups.keys}

  validate :start_time_before_end_time
  validate :user_exists
  validate :session_duration_seconds_non_negative

  private

  def start_time_before_end_time
    return unless end_time.present? && start_time > end_time

    errors.add(:start_time, "must be less than or equal to end_time")
  end

  def user_exists
    return if User.exists?(email:)

    errors.add(:email, "No user exists with this email")
  end

  def session_duration_seconds_non_negative
    return unless session_duration_seconds.present? && session_duration_seconds.negative?

    errors.add(:session_duration_seconds, "must be greater than or equal to 0")
  end
end
