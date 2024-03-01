
# Mongoid syntax
# ScqChallenge seed data
PlacementChallenge::Scq.find_or_create_by!(
  name: "Main Function Syntax",
  difficulty: :EASY,
  question_overview: "Which of the following is a correct syntax to declare the main function in C?",
  answers: ["start main() {}", "function main() {}", "int main() {}", "main(): int {}"],
  correct_answer: 2,
  correct_answer_explanation: "The 'int main() {}' syntax is standard in C for defining the main function that marks the entry point of the program."
)

# McqChallenge seed data
PlacementChallenge::Mcq.find_or_create_by!(
  name: "Loop Constructs",
  difficulty: :MEDIUM,
  question_overview: "Which of the following are valid loop constructs in programming?",
  answers: ['for', 'while', 'do-while', 'foreach'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "The `for`, `while`, and `do-while` loops are standard looping constructs in many programming languages. `foreach` is not universally valid, as its availability and syntax can vary."
)

# ConnectBlocksChallenge seed data
PlacementChallenge::ConnectBlocks.find_or_create_by!(
  name: "Variable Types",
  difficulty: :SIMPLE,
  question_overview: "Match the variable types to their correct descriptions",
  first_group: ["int", "float", "char", "double"],
  second_group: ["Integer", "Floating-point number", "Single character", "Double precision floating-point number"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "int is used for integers, float for single precision floating-point numbers, char for single characters, and double for double precision floating-point numbers."
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
    {question: 'What is the output for input "4"?', select: {
      startLineNumber: 4,
      startColumn: 3,
      endLineNumber: 4,
      endColumn: 41
    }},
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
  name: "File Writing",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

#define MAX 10

int main() {
  FILE *fp;
  int sum = 20;
  fp = fopen("output.txt", "w");
  if(fp != NULL) {
    fprintf(fp, "Final sum is %d", sum);
    fclose(fp);
  }
  return 0;
}},
  question_array: [
    {question: 'What content is written to the file output.txt?', select: {
      startLineNumber: 10,
      startColumn: 5,
      endLineNumber: 10,
      endColumn: 45
    }},
],
  correct_answer_regex_array: ["^Final sum is 20$"],
  correct_answer_explanation: "The program writes the final value of sum to a file named output.txt, with the content 'Final sum is 20'."
)