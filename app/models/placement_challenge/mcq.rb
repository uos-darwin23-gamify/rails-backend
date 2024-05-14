# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren

class PlacementChallenge::Mcq < PlacementChallenge
  field :answers, type: Array
  field :correct_answers, type: Array

  validate :validate_answers, :validate_correct_answers

  def verify_solution(solution)
    return 0 unless solution.is_a?(Array) && solution.all? {|s| s.is_a?(Integer) }

    counter = answers.length
    (0...answers.length).each do |i|
      if (correct_answers.include?(i) && solution.exclude?(i)) ||
         (correct_answers.exclude?(i) && solution.include?(i))
        counter -= 1
      end
    end

    counter.to_f / answers.length
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

  def validate_correct_answers
    unless correct_answers.is_a?(Array) && correct_answers.length.positive? && correct_answers.length <= answers.length
      errors.add(:correct_answers,
                 "must be an array with length greater than 0 and smaller or equal to answers array length")
      return
    end

    correct_answers.each do |correct_answer|
      unless correct_answer.is_a?(Integer) && correct_answer >= 0 && correct_answer < answers.length
        errors.add(:correct_answers, "#{correct_answer} must be a valid index of answers array")
      end
    end
  end
end

# rubocop:enable Style/ClassAndModuleChildren
