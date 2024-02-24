# frozen_string_literal: true

class PlacementChallenge
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "placement_challenges"
  field :name, type: String
  field :question_overview, type: String
  field :correct_answer_explanation, type: String
  field :difficulty, type: String

  # =========================================================
  # ELO CALCULATION CONSTANTS

  K = 40

  # =========================================================
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
end
