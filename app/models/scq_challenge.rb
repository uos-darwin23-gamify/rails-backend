# frozen_string_literal: true

class ScqChallenge < Challenge
  field :answers, type: Array
  field :correct_answer, type: Integer

  validate :validate_answers, :validate_correct_answer

  def verify_solution(solution)
    solution.is_a?(Integer) && solution == correct_answer
  end

  private

  def validate_answers
    unless answers.is_a?(Array) && answers.length.positive?
      errors.add(:answers, "must be an array with length greater than 0")
      return
    end

    answers.each do |answer|
      unless answer.is_a?(String) && answer.length.positive?
        errors.add(:answers, "#{answer} must be a string with length greater than 0")
      end
    end
  end

  def validate_correct_answer
    return if correct_answer.is_a?(Integer) && correct_answer >= 0 && correct_answer < answers.length

    errors.add(:correct_answer,
               "must be an integer greater than or equal to 0 and less than the length of answers array")
  end
end
