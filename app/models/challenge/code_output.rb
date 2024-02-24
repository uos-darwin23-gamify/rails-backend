# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren

class Challenge::CodeOutput < Challenge
  field :code, type: String
  field :question_array, type: Array
  field :correct_answer_regex_array, type: Array

  validates :code, length: {minimum: 1}
  validate :validate_correct_answer_regex_length, :validate_correct_answer_regex_content,
           :validate_question_content

  def verify_solution(solution)
    solution.is_a?(Array) &&
    solution.all? {|s| s.is_a?(String) } &&
    solution.length == correct_answer_regex_array.length &&
    solution.zip(correct_answer_regex_array).all? {|s, regex| Regexp.new(regex).match?(s) }
  end

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
      unless q.is_a?(Hash) && valid_question_hash?(q)
        errors.add(:question_array, "#{q} must be a hash with valid properties")
      end
    end
  end

  def valid_question_hash?(hash)
    hash.key?(:question) && hash[:question].is_a?(String) && hash[:question].length.positive? && valid_select_hash?(hash[:select])
  end

  def valid_select_hash?(hash)
    return true unless hash

    hash.is_a?(Hash) && hash.key?(:startLineNumber) && hash.key?(:startColumn) && hash.key?(:endLineNumber) && hash.key?(:endColumn) &&
    hash[:startLineNumber].is_a?(Integer) && hash[:startColumn].is_a?(Integer) && hash[:endLineNumber].is_a?(Integer) && hash[:endColumn].is_a?(Integer)
  end
end

# rubocop:enable Style/ClassAndModuleChildren
