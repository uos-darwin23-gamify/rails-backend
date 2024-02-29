# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end

require_relative 'challenges'
require_relative 'placement_challenges'

# Active Record syntax
PreAuthorizedEmail.find_or_create_by!(:email => "admin@test.com", group: PreAuthorizedEmail.groups["admin_group"])

# Mongoid syntax
# ScqChallenge seed data
Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Main Function Syntax",
  difficulty: :EASY,
  question_overview: "Which of the following is a correct syntax to declare the main function in C?",
  answers: ["start main() {}", "function main() {}", "int main() {}", "main(): int {}"],
  correct_answer: 2,
  correct_answer_explanation: "The 'int main() {}' syntax is standard in C for defining the main function that marks the entry point of the program."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Print Hello World",
  difficulty: :SIMPLE,
  question_overview: "What line will print 'Hello World!' to the console in C?",
  answers: ["print(\"Hello World!\");", "echo \"Hello World!\";", "printf(\"Hello World!\n\");", "cout << \"Hello World!\";"],
  correct_answer: 2,
  correct_answer_explanation: "printf(\"Hello World!\n\");' uses the printf function from the C standard library to print \"Hello World!\" followed by a new line to the console."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Adding a Single-line Comment",
  difficulty: :EASY,
  question_overview: "Which of the following demonstrates adding a single-line comment in C?",
  answers: ["// This is a comment", "<!-- This is a comment -->", "# This is a comment", "/* This is a comment */"],
  correct_answer: 0,
  correct_answer_explanation: "// This is a comment' is the syntax for a single-line comment in C and C++."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Standard Input Library Directive",
  difficulty: :MEDIUM,
  question_overview: "Which directive is used to include standard input and output facilities in C?",
  answers: ["#include \"stdio.h\"", "#include <stdio.h>", "#import <stdio.h>", "#include <iostream>"],
  correct_answer: 1,
  correct_answer_explanation: "#include <stdio.h>' is used to include the Standard Input and Output Library in C, which contains declarations for input and output functions."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Dynamic Memory Allocation for Integer Array",
  difficulty: :HARD,
  question_overview: "How do you allocate memory dynamically for an array of 10 integers?",
  answers: ["malloc(10 * sizeof(int))", "new int[10]", "int malloc[10]", "allocate(10)"],
  correct_answer: 0,
  correct_answer_explanation: "Memory for an array can be dynamically allocated using the malloc function, which allows for flexible array sizes at runtime."
)

# McqChallenge seed data
Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Operator Precedence in C",
  difficulty: :HARD,
  question_overview: "Which of these operators have the same precedence level in C?",
  answers: ['+ and -', '* and /', '== and !=', '& and |'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "In C, `*` and `/` have the same precedence level, which is higher than that of `+` and `-`. Similarly, `==` and `!=` have the same precedence level, which is lower than the arithmetic operators but higher than assignment operators."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Loop Constructs",
  difficulty: :MEDIUM,
  question_overview: "Which of the following are valid loop constructs in programming?",
  answers: ['for', 'while', 'do-while', 'foreach'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "The `for`, `while`, and `do-while` loops are standard looping constructs in many programming languages. `foreach` is not universally valid, as its availability and syntax can vary."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Array Initialization",
  difficulty: :EASY,
  question_overview: "How could you correctly initialize an array of integers in C?",
  answers: ['int arr[5] = {1,2,3,4,5};', 'int arr[] = {1,2,3,4,5};', 'int[5] arr = {1,2,3,4,5};', '{1,2,3,4,5} int arr;'],
  correct_answers: [0, 1],
  correct_answer_explanation: "Arrays in C can be initialized by directly specifying the values within curly braces. Both `int arr[5] = {1,2,3,4,5};` and `int arr[] = {1,2,3,4,5};` are correct methods of initialization. The other options are syntactically incorrect."
)

# ConnectBlocksChallenge seed data
Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Variable Types",
  difficulty: :SIMPLE,
  question_overview: "Match the variable types to their correct descriptions",
  first_group: ["int", "float", "char", "double"],
  second_group: ["Integer", "Floating-point number", "Single character", "Double precision floating-point number"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "int is used for integers, float for single precision floating-point numbers, char for single characters, and double for double precision floating-point numbers."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Program Basics",
  difficulty: :EASY,
  question_overview: "Match the components of a C program to their descriptions",
  first_group: ["main()", "#include <stdio.h>", "return 0;", "printf"],
  second_group: ["Entry point of the program", "Preprocessor directive for input/output", "Terminates the program successfully", "Function to output text"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "main() is where execution starts, #include <stdio.h> is used for I/O operations, return 0; signifies successful program termination, and printf is used to output text."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Operator Matching",
  difficulty: :MEDIUM,
  question_overview: "Match the operators to their correct descriptions",
  first_group: ["==", "++", "&&", "%"],
  second_group: ["Equality", "Increment", "Logical AND", "Modulus"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Equality (==) checks if two values are equal, Increment (++) increases a value by 1, Logical AND (&&) requires both conditions to be true, and Modulus (%) returns the remainder of a division."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Advanced I/O Matching",
  difficulty: :HARD,
  question_overview: "Match the printf/scanf specifiers to their uses",
  first_group: ["%d", "%f", "%c", "%s"],
  second_group: ["Integer", "Floating-point number", "Character", "String"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "%d is used for integers, %f for floating-point numbers, %c for characters, and %s for strings."
)

# CodeOutputChallenge seed data
Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
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
Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Iterate and Sum",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

#define MAX 10

int main() {
  int arr[MAX] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
  int *ptr = arr;
  int sum = 0;
    for (int i = 0; i < MAX; i++) {
      if (i % 2 == 0) {
        sum += *(ptr + i);
      } else {
        printf("%d ", *(ptr + i)); 
      }
    }
    printf("\nSum: %d\n", sum); 

    return 0;
}},
  question_array: [
    {question: 'What is the output to the console?'},
    {question: 'What is the value of sum at the end of the program?', select: {
      startLineNumber: 13,
      startColumn: 10,
      endLineNumber: 16,
      endColumn: 40
    }},
    {question: 'How many times is the loop executed?', select: {
      startLineNumber: 9,
      startColumn: 3,
      endLineNumber: 9,
      endColumn: 40
    }},
],
  correct_answer_regex_array: ["^1 3 5 7 9 \\nSum: 20$", "^20$", "^10$"],
  correct_answer_explanation: "The program iterates over the array arr and prints odd numbers, along with the sum of the even numbers at the end. The loop is executed 10 times."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "Pointer Arithmetic",
  difficulty: :MEDIUM,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

#define MAX 10

int main() {
  int arr[MAX] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
  int *ptr = arr;
  printf("%d", *(ptr + 5));
  return 0;
}},
  question_array: [
    {question: 'What is the value of *(ptr + 5) after the code executes?', select: {
      startLineNumber: 8,
      startColumn: 3,
      endLineNumber: 8,
      endColumn: 30
    }},
],
  correct_answer_regex_array: ["^5$"],
  correct_answer_explanation: "Pointer arithmetic is used to access the 6th element of the array (index 5), which has a value of 5."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/02/2024', '%d/%m/%Y'),
  name: "File Writing",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>
  
void writeFile(const char *filename, const char *content) {
    FILE *fp = fopen(filename, "w");
    if (fp != NULL) {
        fputs(content, fp);
        fclose(fp);
    }
}

int countDigits(const char *str) {
    int count = 0;
    while (*str) {
        if (*str >= '0' && *str <= '9') count++;
        str++;
    }
    return count;
}

int main() {
    const char *msg = "Hello123World45!";
    writeFile("output.txt", msg);

    int digits = countDigits(msg);
    printf("Number of digits in message: %d\n", digits);

    return 0;
}},
  question_array: [
    {question: 'What is written to output.txt?', select: {
      startLineNumber: 21,
      startColumn: 5,
      endLineNumber: 21,
      endColumn: 45
    }},
    {question: 'What is the output of the printf statement in main?', select: {
      startLineNumber: 24,
      startColumn: 3,
      endLineNumber: 24,
      endColumn: 40
    }},
],
  correct_answer_regex_array: ["^Hello123World45!$","^Number of digits in message: 5$"],
  correct_answer_explanation: "The function writeFile writes the string msg to output.txt. The function countDigits counts the number of digits in the string msg, which contains 5 digits (12345)."
)