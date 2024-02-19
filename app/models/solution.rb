# frozen_string_literal: true

class Solution < ApplicationRecord
  validate :challenge_exists
  validate :start_time_before_end_time
  validate :answer_is_valid_json

  belongs_to :user, foreign_key: "user_email", primary_key: "email"

  private

  def challenge_exists
    errors.add(:challenge_oid, "doesn't exist") unless Challenge.exists?(challenge_oid)
    #   errors.add(:challenge_oid, "doesn't exist") unless Challenge.exists?(oid: challenge_oid)
  end

  def start_time_before_end_time
    return unless end_time.present? && start_time > end_time

    errors.add(:start_time, "must be before end time")
  end

  def answer_is_valid_json
    return if answer.blank?

    begin
      JSON.parse(answer)
    rescue JSON::ParserError
      errors.add(:answer, "must be a valid JSON string")
    end
  end
end
