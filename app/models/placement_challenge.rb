# frozen_string_literal: true

class PlacementChallenge
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "placement_challenges"
  field :name, type: String
  field :question_overview, type: String
  field :correct_answer_explanation, type: String
  field :difficulty, type: String

  K = Constants::ADJUSTMENT_FACTOR_PLACEMENT

  DIFFICULTIES = %w[SIMPLE EASY MEDIUM HARD EXTREME].freeze

  validates :name, :question_overview, :correct_answer_explanation, length: {minimum: 1}
  validates :difficulty, inclusion: {in: DIFFICULTIES}

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
end
