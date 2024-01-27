# frozen_string_literal: true

class Challenge
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "challenges"
  field :name, type: String
  field :difficulty, type: Symbol

  DIFFICULTIES = %i[EASY MEDIUM HARD].freeze

  validates :name, uniqueness: true
  validates :difficulty, inclusion: {in: DIFFICULTIES}

  def challenge_type
    _type
  end
end
