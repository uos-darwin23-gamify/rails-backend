# frozen_string_literal: true

class Challenge
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "challenges"
  field :name, type: String
  field :question_overview, type: String
  field :correct_answer_explanation, type: String
  field :difficulty, type: String
  field :date_when_available, type: Date

  K = Constants::ADJUSTMENT_FACTOR_NORMAL

  DIFFICULTIES = %w[SIMPLE EASY MEDIUM HARD EXTREME].freeze

  validates :name, :question_overview, :correct_answer_explanation, length: {minimum: 1}
  validates :difficulty, inclusion: {in: DIFFICULTIES}
  validates :date_when_available, presence: true

  def type
    "#{_type.split('::').last}Challenge"
  end

  def id
    _id.to_s
  end

  def verify_solution(solution)
    raise NotImplementedError, "Subclasses must define 'verify_solution'."
  end

  def difficulty_level
    case difficulty
    when "SIMPLE"
      Constants::DIFFICULTY_0
    when "EASY"
      Constants::DIFFICULTY_1
    when "MEDIUM"
      Constants::DIFFICULTY_2
    when "HARD"
      Constants::DIFFICULTY_3
    when "EXTREME"
      Constants::DIFFICULTY_4
    else
      Constants::DIFFICULTY_0
    end
  end

  def adjustment_factor
    self.class::K
  end

  def self.available_today
    where(date_when_available: Time.zone.today)
  end

  def self.available_in_past
    where(:date_when_available.lt => Time.zone.today)
  end

  def available_today?
    Time.zone.today == date_when_available
  end

  def available_in_past?
    Time.zone.today > date_when_available
  end

  def self.offset_date_when_available_by(days)
    all.each do |challenge|
      challenge.date_when_available += days
      challenge.save
    end
  end
end
