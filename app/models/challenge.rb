# frozen_string_literal: true

class Challenge
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "challenges"
  field :name, type: String
  field :question_overview, type: String
  field :correct_answer_explanation, type: String
  field :difficulty, type: String
  field :answers, type: Array
  field :correct_answers, type: Array
  field :correct_answer, type: String
  field :_type, type: String
  field :first_group, type: String
  field :second_group, type: String
  DIFFICULTIES = %w[EASY MEDIUM HARD].freeze

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
