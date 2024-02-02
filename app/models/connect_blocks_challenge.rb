# frozen_string_literal: true

class ConnectBlocksChallenge < Challenge
  field :first_group, type: Array
  field :second_group, type: Array
  field :correct_answers, type: Array

  validate :validate_first_group, :validate_second_group, :validate_correct_answers

  def verify_solution(solution)
    solution.is_a?(Array) && 
    solution.all? { |s| s.is_a?(Array) && s.length == 2 && s.all? { |i| i.is_a?(Integer) } } &&
    solution.uniq.length == solution.length &&
    solution.sort == correct_answers.sort
  end

  private

  def validate_first_group
    validate_group(:first_group, first_group)
  end

  def validate_second_group
    validate_group(:second_group, second_group)
  end

  def validate_group(field, group)
    unless group.is_a?(Array) && group.length > 0
      errors.add(field, "must be an array with length greater than 0")
      return
    end

    group.each do |item|
      unless item.is_a?(String) && item.length > 0
        errors.add(field, "#{item} must be a string with length greater than 0")
      end
    end
  end

  def validate_correct_answers
    unless correct_answers.is_a?(Array) && correct_answers.length > 0
      errors.add(:correct_answers, "must be an array with length greater than 0")
      return
    end

    if correct_answers.uniq.length != correct_answers.length
      errors.add(:correct_answers, "must not contain duplicate entries")
      return
    end

    correct_answers.each do |answer|
      unless answer.is_a?(Array) && answer.length == 2 && answer.all? { |i| i.is_a?(Integer) }
        errors.add(:correct_answers, "#{answer} must be an array of exactly two integers")
        next
      end

      unless answer[0].between?(0, first_group.length - 1) && answer[1].between?(0, second_group.length - 1)
        errors.add(:correct_answers, "#{answer} contains an invalid index")
      end
    end
  end
end