# frozen_string_literal: true

class GlobalLeaderboard
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "global_leaderboard"

  field :timestamp, type: Time, default: -> { Time.zone.now }
  field :leaderboard, type: Array

  validates :leaderboard, presence: true
  validate :validate_leaderboard
  validates :timestamp, presence: true

  def id
    _id.to_s
  end

  def self.latest_entry
    order_by(timestamp: :desc).first
  end

  private

  def validate_leaderboard
    leaderboard.each do |player|
      errors.add(:leaderboard, "username must exist") unless User.exists?(username: player[:username])
      errors.add(:leaderboard, "elo must be greater or equal to 0") if player[:elo].negative?
    end
    leaderboard.sort_by! {|player| -player[:elo] }
  end
end
