
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


PlacementChallenge::Mcq.find_or_create_by!(
  name: 'Variables',
  difficulty: :EASY,
  question_overview: "How to declare a floating-point variable named 'temp'?",
  answers: ["float temp;", "int temp;", "double temp;", "char temp;"],
  correct_answers: [0,2],
  correct_answer_explanation: "A floating-point variable can be declared using the 'float' or 'double' keyword followed by the variable name."
)

# McqChallenge seed data
PlacementChallenge::Mcq.find_or_create_by!(
  name: "Loop Constructs",
  difficulty: :MEDIUM,
  question_overview: "Which of the following are valid loop constructs in C programming?",
  answers: ['for', 'while', 'do-while', 'foreach'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "The `for`, `while`, and `do-while` loops are standard looping constructs in many programming languages. `foreach` is not universally valid, as its availability and syntax can vary."
)

PlacementChallenge::ConnectBlocks.find_or_create_by!(
  name: "Switch Statements",
  difficulty: :MEDIUM,
  question_overview: "Match the components of a switch statement with their descriptions.",
  first_group: ["switch", "case", "break", "default"],
  second_group: ["Starts the switch statement", "Represents a branch based on a value", "Exits the switch statement", "Executes if no case matches"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "switch to initiate, case for value-based branches, break to exit, default for no match."
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

PlacementChallenge::ConnectBlocks.find_or_create_by!(
  name: "Macros",
  difficulty: :SIMPLE,
  question_overview: "Match the following #define macros with their correct usage.",
  first_group: ["#define PI 3.14", "#define SQUARE(x) ((x) * (x))", "#define MAX(a, b) ((a) > (b) ? (a) : (b))", "#define CHECK_ZERO(x) ((x) == 0 ? 1 : 0)"],
  second_group: ["Used to define a constant for PI", "Used to define a macro for squaring a number", "Used to define a macro to find the maximum of two numbers", "Used to define a macro to check if a number is zero"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "PI is defined as 3.14, SQUARE computes the square of x, MAX returns the maximum of a and b, CHECK_ZERO checks if x is zero."
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
  # printf("%d is a prime number.", num);
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

PlacementChallenge::CodeOutput.find_or_create_by!(
  name: "Pointers",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>
#include <stdlib.h>

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
    printf("Number of digits in message: %d ", digits);

    return 0;
}},
question_array: [
    {question: 'If msg were changed to "2024NewYear", how many digits would countDigits return?'},
    {question: 'What is the initial character pointed to by the *str pointer in the countDigits function when called with msg?'}
],
  correct_answer_regex_array: ["^4$", "^H$"],
  correct_answer_explanation: "The new string contains 4 digits (2024). The pointer *str initially points to the first character of msg, which is H."
)

PlacementChallenge::CodeOutput.find_or_create_by!(
  name: "Arrays",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int numbers[3] = {5, 10, 15};
    int *p = numbers;
    int offset = 1;

    *p = *p + 1;  
    *(p + offset) = *(p + offset) * 2;  
    p[offset + 1] = p[offset + 1] - 5;  

    printf("First = %d, Second = %d, Third = %d ", numbers[0], numbers[1], numbers[2]);
    
    return 0;
}},
question_array: [
    {question: 'What is the final value of the first element in the numbers array?'},
    {question: 'What is the value of the second element in the numbers array after the code execution?'}
],
  correct_answer_regex_array: ["^6$","^20$"],
  correct_answer_explanation: "The first element (*p) is incremented by 1, changing from 5 to 6. The second element (*(p + offset) where offset is 1) is doubled, changing from 10 to 20."
)


PlacementChallenge::CodeOutput.find_or_create_by!(
  name: "String Concatenation",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>
#include <string.h>

int main() {
    char str1[20] = "Hello";
    char str2[] = "World";
    strcat(str1, str2);

    printf("%s ", str1);
    int length = strlen(str1);

    for(int i = 0; i < length; i++) {
        if(str1[i] == 'o') {
            str1[i] = 'a';
        }
    }

    printf("%s ", str1);
    return 0;
}},
question_array: [
    {question: 'What is the final content of str1 after the loop? (do not include any " in your answer)'},
    {question: 'What is the value of str1[5] after the loop?'}
],
  correct_answer_regex_array: ["^HellaWarld$", "^a$"],
  correct_answer_explanation: "The loop changes every 'o' in str1 to 'a', resulting in 'HellaWarld'. The sixth character ('o') is changed to 'a' by the loop."
)