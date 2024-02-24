
# Mongoid syntax
# ScqChallenge seed data
PlacementChallenge::Scq.find_or_create_by!(
  name: "Capital Cities",
  difficulty: :SIMPLE,
  # question_overview: "Choose the correct answer",
  question_overview: "What is the capital of France?",
  answers: ["Paris", "Madrid", "London", "Edinburgh of the Seven Seas"],
  correct_answer: 0,
  correct_answer_explanation: "The capital of France is Paris. Madrid is the capital of Spain, London is the capital of the UK, and Edinburgh of the Seven Seas is a settlement on the island of Tristan da Cunha."
)

# McqChallenge seed data
PlacementChallenge::Mcq.find_or_create_by!(
  name: "General Geography Knowledge",
  difficulty: :EASY,
  # question_overview: "Choose all of the correct answers",
  question_overview: "Which of the following are correct?",
  answers: ["London is in the UK", "Paris is in France", "New York is the capital of the US", "Edinburgh of the Seven Seas is in Brazil"],
  correct_answers: [0, 1],
  correct_answer_explanation: "London is indeed in the UK and Paris is in France. However, New York is not the capital of the US, that's Washington D.C. Also, Edinburgh of the Seven Seas is not in Brazil, it's a settlement on the island of Tristan da Cunha."
)

# ConnectBlocksChallenge seed data
PlacementChallenge::ConnectBlocks.find_or_create_by!(
  name: "Category Matching",
  difficulty: :MEDIUM,
  # question_overview: "Connect all matching blocks",
  question_overview: "Match the objects to the correct categories",
  first_group: ["Fruit", "Vegetable", "City"],
  second_group: ["Banana", "Potato", "Cherry", "Big Apple", "Shanghai"],
  correct_answers: [[0, 0], [1, 1], [0, 2], [0, 3], [2, 3], [2, 4]],
  correct_answer_explanation: "Banana and Cherry are fruits, Potato is a vegetable, and Big Apple (a nickname for New York City) and Shanghai are cities."
)

# CodeOutputChallenge seed data
PlacementChallenge::CodeOutput.find_or_create_by!(
  name: "Prime Numbers",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  # question_overview: "What is the output of the code?",
  code: %Q{#include <stdio.h>
int main() {
  int num, i, isPrime = 1;
  printf("Enter a positive integer: ");
  scanf("%d", &num);
  for (i = 2; i <= num / 2; ++i) {
    if (num % i == 0) {
      isPrime = 0;
      break;
    }
  }
  if (isPrime)
    printf("%d is a prime number.", num);
  else
    printf("%d is not a prime number.", num);
  return 0;
}},
  # Escaping special characters:
  # printf("%d is a prime number.\\n", num);
  question_array: [
    {question: 'What is the output for input "4"?'},
    {question: 'What is the output for input "7"?', select: {
      startLineNumber: 4,
      startColumn: 3,
      endLineNumber: 4,
      endColumn: 41
    }},
    {question: 'What does the main() function actually return?', select: {
      startLineNumber: 2,
      startColumn: 1,
      endLineNumber: 18,
      endColumn: 1
    }},
],
  correct_answer_regex_array: ["^4 is not a prime number.$", "^7 is a prime number.$", "^0$"],
  # Example with any combination of preceding and/or trailing character sequences permitted:
  # correct_answer_regex_array: ["4 is not a prime number.", "7 is a prime number.", "0"],
  correct_answer_explanation: "The code is a simple C program to check if a number is prime. For input '4', the output is '4 is not a prime number.' because 4 is not a prime number. For input '7', the output is '7 is a prime number.' because 7 is a prime number. The main() function returns '0' indicating successful execution of the program."
)

# CodeOutputChallenge seed data
PlacementChallenge::CodeOutput.find_or_create_by!(
  name: "Prime Numbers",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  # question_overview: "What is the output of the code?",
  code: %Q{#include <stdio.h>
int main() {
  int num, i, isPrime = 1;
  printf("Enter a positive integer: ");
  scanf("%d", &num);
  for (i = 2; i <= num / 2; ++i) {
    if (num % i == 0) {
      isPrime = 0;
      break;
    }
  }
  if (isPrime)
    printf("%d is a prime number.", num);
  else
    printf("%d is not a prime number.", num);
  return 0;
}},
  # Escaping special characters:
  # printf("%d is a prime number.\\n", num);
  question_array: [
    {question: 'What is the output for input "4"?'},
    {question: 'What is the output for input "7"?', select: {
      startLineNumber: 4,
      startColumn: 3,
      endLineNumber: 4,
      endColumn: 41
    }},
    {question: 'What does the main() function actually return?', select: {
      startLineNumber: 2,
      startColumn: 1,
      endLineNumber: 18,
      endColumn: 1
    }},
],
  correct_answer_regex_array: ["^4 is not a prime number.$", "^7 is a prime number.$", "^0$"],
  # Example with any combination of preceding and/or trailing character sequences permitted:
  # correct_answer_regex_array: ["4 is not a prime number.", "7 is a prime number.", "0"],
  correct_answer_explanation: "The code is a simple C program to check if a number is prime. For input '4', the output is '4 is not a prime number.' because 4 is not a prime number. For input '7', the output is '7 is a prime number.' because 7 is a prime number. The main() function returns '0' indicating successful execution of the program."
)