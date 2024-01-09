# frozen_string_literal: true

class NoSqlPlaceholder
  include Mongoid::Document
  include Mongoid::Timestamps
  store_in collection: "no_sql_placeholder"

  field :name, type: String

  validates :name, uniqueness: true
end
