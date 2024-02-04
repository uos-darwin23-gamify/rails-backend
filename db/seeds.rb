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
# ScqChallenge seed data
ScqChallenge.find_or_create_by(
  name: "Single choice question challenge 1",
  difficulty: :EASY,
  # question_overview: "Choose the correct answer",
  question_overview: "What is the capital of France?",
  answers: ["Paris", "Madrid", "London", "Edinburgh of the Seven Seas"],
  correct_answer: 0,
  correct_answer_explanation: "The capital of France is Paris. Madrid is the capital of Spain, London is the capital of the UK, and Edinburgh of the Seven Seas is a settlement on the island of Tristan da Cunha."
)

# McqChallenge seed data
McqChallenge.find_or_create_by(
  name: "Multiple choice question challenge 1",
  difficulty: :MEDIUM,
  # question_overview: "Choose all of the correct answers",
  question_overview: "Which of the following are correct?",
  answers: ["London is in the UK", "Paris is in France", "New York is the capital of the US", "Edinburgh of the Seven Seas is in Brazil"],
  correct_answers: [0, 1],
  correct_answer_explanation: "London is indeed in the UK and Paris is in France. However, New York is not the capital of the US, that's Washington D.C. Also, Edinburgh of the Seven Seas is not in Brazil, it's a settlement on the island of Tristan da Cunha."
)

# ConnectBlocksChallenge seed data
ConnectBlocksChallenge.find_or_create_by(
  name: "Connect blocks challenge 1",
  difficulty: :HARD,
  # question_overview: "Connect all matching blocks",
  question_overview: "Match the objects to the correct categories",
  first_group: ["Fruit", "Vegetable", "City"],
  second_group: ["Banana", "Potato", "Cherry", "Big Apple", "Shanghai"],
  correct_answers: [[0, 0], [1, 1], [0, 2], [0, 3], [2, 3], [2, 4]],
  correct_answer_explanation: "Banana and Cherry are fruits, Potato is a vegetable, and Big Apple (a nickname for New York City) and Shanghai are cities."
)

# CodeOutputChallenge seed data
CodeOutputChallenge.find_or_create_by(
  name: "Code output challenge 1",
  difficulty: :HARD,
  # question_overview: "Analyze the code",
  question_overview: "What is the output of the code?",
  code: "print('Hello, world!')",
  question_array: ["Output:"],
  correct_answer_regex_array: ["^Hello, world!$"],
  correct_answer_explanation: "The print function in Python outputs the string 'Hello, world!' to the console."
)