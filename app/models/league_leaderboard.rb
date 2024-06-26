# frozen_string_literal: true

class LeagueLeaderboard
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "league_leaderboard"

  field :timestamp, type: Time, default: -> { Time.zone.now }
  field :leaderboard, type: Array
  field :unlocked_leagues, type: Array

  LEAGUE = %w[BRONZE SILVER GOLD SAPPHIRE RUBY EMERALD AMETHYST PEARL OBSIDIAN
              DIAMOND].freeze

  validates :leaderboard, presence: true
  validate :validate_leaderboard
  validates :timestamp, presence: true
  validates :unlocked_leagues, presence: true
  validate :validate_unlocked_leagues

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
      errors.add(:leaderboard, "invalid league") unless LEAGUE.include?(player[:league])
    end
    leaderboard.sort_by! {|player| -player[:elo] }
  end

  def validate_unlocked_leagues
    unless unlocked_leagues.all? {|league| LEAGUE.include?(league) }
      errors.add(:unlocked_leagues, "must be a subset of LEAGUE")
    end

    return if unlocked_leagues == unlocked_leagues.sort_by {|league| LEAGUE.index(league) }

    errors.add(:unlocked_leagues, "must preserve the order of LEAGUE")
  end
end
