# frozen_string_literal: true

class CodeOutputChallenge < Challenge
  field :code, type: String
  field :question_array, type: Array
  field :correct_answer_regex_array, type: Array

  validates :code, length: { minimum: 1 }
  validate :validate_correct_answer_regex_length, :validate_correct_answer_regex_content, :validate_question_content

  private

  def validate_correct_answer_regex_length
    return unless correct_answer_regex_array.length != question_array.length

    errors.add(:correct_answer_regex_array, "length must be equal to question array length")
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
      unless q.is_a?(String) && q.length > 0
        errors.add(:question_array, "#{q} must be a string with length greater than 0")
      end
    end
  end
end