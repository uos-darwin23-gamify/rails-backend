# frozen_string_literal: true

class McqChallenge < Challenge
  field :question, type: String
  field :answers, type: Array
  field :correct_answer, type: Integer

  validates :correct_answer, numericality: {greater_than_or_equal_to: 0}
  validate :validate_correct_answer_range, :validate_answers_content

  private

  def validate_correct_answer_range
    return unless correct_answer >= answers.length

    errors.add(:correct_answer, "must be less than answers length")
  end

  def validate_answers_content
    answers.each do |answer|
      errors.add(:answers, "#{answer} is not a string") unless answer.is_a?(String)
    end
  end
end
