# frozen_string_literal: true

class FillBlankChallenge < Challenge
  field :question_array, type: Array
  field :correct_answer_regex_array, type: Array

  validate :validate_correct_answer_regex_length, :validate_correct_answer_regex_content, :validate_question_content

  private

  def validate_correct_answer_regex_length
    return unless correct_answer_regex_array.length != question_array.length - 1

    errors.add(:correct_answer_regex_array, "length must be one less than question array length")
  end

  def validate_correct_answer_regex_content
    correct_answer_regex_array.each do |regex|
      Regexp.new(regex)
    rescue RegexpError
      errors.add(:correct_answer_regex_array, "#{regex} is not a valid regex")
    end
  end

  def validate_question_content
    question_array.each do |q|
      errors.add(:question_array, "#{q} is not a string") unless q.is_a?(String)
    end
  end
end
