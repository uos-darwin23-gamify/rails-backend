# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Active Record syntax
PreAuthorizedEmail.find_or_create_by(:email => "test@test.com")

# Mongoid syntax
# FillBlankChallenge seed data
FillBlankChallenge.find_or_create_by(
  name: "Fill in the blank challenge 1",
  difficulty: :EASY,
  question_array: ["", " is the capital of France and ", " is the capital of Spain."],
  correct_answer_regex_array: ["^Paris$", "^Madrid$"]
)

# McqChallenge seed data
McqChallenge.find_or_create_by(
  name: "Multiple choice question challenge 1",
  difficulty: :MEDIUM,
  question: "What is the capital of Italy?",
  answers: ["Rome", "Paris", "Madrid", "Berlin"],
  correct_answer: 0
)

# DragDropChallenge seed data
DragDropChallenge.find_or_create_by(
  name: "Drag and drop challenge 1",
  difficulty: :HARD,
  items: ["Apple", "Banana", "Cherry"],
  correct_order: ["Banana", "Cherry", "Apple"]
)