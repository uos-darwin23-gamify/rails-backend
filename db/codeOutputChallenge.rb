
# CodeOutputChallenge seed data
Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('08/03/2024', '%d/%m/%Y'), #8
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
  date_when_available: Date.strptime('09/03/2024', '%d/%m/%Y'), #9
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
    printf("\\nSum: %d", sum); 

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
  date_when_available: Date.strptime('14/03/2024', '%d/%m/%Y'), #14
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
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'), 
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
    printf("Number of digits in message: %d\\n", digits);

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

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Pointers",
  difficulty: :MEDIUM,
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
    printf("\\nSum: %d\\n", sum); 

    FILE *fp = fopen("output.txt", "w");
    if (fp != NULL) { 
        fprintf(fp, "Final sum is %d", sum);
        fclose(fp);
    }

    return 0;
}},
question_array: [
    {question: 'What is the value of *(ptr + 5) after the code has been executed?'}
],
  correct_answer_regex_array: ["^5$"],
  correct_answer_explanation: "Pointer arithmetic is used to access the 6th element in the array (since array indexing starts at 0), which is 5."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('09/03/2024', '%d/%m/%Y'),  #9
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
    printf("Number of digits in message: %d\\n", digits);

    return 0;
}},
question_array: [
    {question: 'If msg were changed to "2024NewYear", how many digits would countDigits return?'},
    {question: 'What is the initial character pointed to by the *str pointer in the countDigits function when called with msg?'}
],
  correct_answer_regex_array: ["^4$", "^H$"],
  correct_answer_explanation: "The new string contains 4 digits (2024). The pointer *str initially points to the first character of msg, which is H."
)
#2q
Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('22/03/2024', '%d/%m/%Y'), #22
  name: "Odd or Even",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int num = 10;
    int count = 5;
    while (count > 0) {
        if (num % 2 == 0) {
            printf("%d is even\\n", num);
        } else {
            printf("%d is odd\\n", num);
        }
        num++;
        count--;
    }
    return 0;
}},
question_array: [
    {question: 'What is the output of the program?'},
    {question: 'What is the final value of num when the program finishes execution?'}
],
  correct_answer_regex_array: ["^10 is even
  11 is odd
  12 is even
  13 is odd
  14 is even$",
  "^15$"],
  correct_answer_explanation: "The program checks if each num from 10 to 14 is even or odd and prints the corresponding message. The num variable starts at 10 and is incremented in each of the 5 iterations of the loop, ending at 15 when the program completes."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('10/03/2024', '%d/%m/%Y'), #10
  name: "Positive or Negative",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int a = 4, b = 3;
    int result = a - b;
    if (result > 0) {
        printf("Positive\\n");
    } else if (result == 0) {
        printf("Zero\\n");
    } else {
        printf("Negative\\n");
    }

    for (int i = 0; i < a; i++) {
        printf("%d ", i * b);
    }

    return 0;
}},
question_array: [
    {question: 'What is the output of the if-else block in this program?'},
    {question: 'What is the output from the for loop?'},
    {question: 'What will the output of the whole program be if "a" is changed to 3?'}
],
  correct_answer_regex_array: ["Positive$", "^0 3 6 9$", "^Zero
  0 3 6$"],
  correct_answer_explanation: "The if-else block checks the value of result, which is the result of a - b (4 - 3 = 1). Since 1 is greater than 0, the program prints 'Positive'. The for loop iterates with i starting from 0 up to less than a (4). In each iteration, it prints i * b, which produces the sequence 0 (0x3), 3 (1x3), 6 (2x3), and 9 (3x3). If both a and b are 3, result becomes 0, triggering the else if branch to print 'Zero'. The for loop will iterate three times (0, 1, 2) and print 0 3 6. "
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('11/03/2024', '%d/%m/%Y'), #11
  name: "if-else Execution",
  difficulty: :EASY,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int a = 5;
    int b = 3;
    int c = a + b;
    if (c % 2 == 0) {
        printf("A");
    } else {
        printf("B");
    }
    return 0;
}},
question_array: [
    {question: 'What is the output of this program?'}
],
  correct_answer_regex_array: ["^A$"],
  correct_answer_explanation: "After calculating the sum of a and b, which is 5 + 3 = 8, the program checks if c (8) is even or odd by evaluating c % 2. Since 8 % 2 equals 0, the number is even, so the condition c % 2 == 0 is true. Therefore, the program prints 'A'. "
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'), 
  name: "Pointers",
  difficulty: :MEDIUM,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int x = 5;
    int y = 15;
    int *ptr1 = &x;
    int *ptr2 = &y;
    *ptr1 = *ptr1 + *ptr2;

    printf("x = %d, y = %d\\n", x, y);
    return 0;
}},
question_array: [
    {question: 'What is the value of x at the end of this program?'}
],
  correct_answer_regex_array: ["^20$"],
  correct_answer_explanation: "Before the operation, ptr1 points to x (5) and ptr2 points to y (15). The line *ptr1 = *ptr1 + *ptr2; modifies the value of x by adding the value of y to it, making x equal to 20 (5 + 15). The value of y remains unchanged at 15."
)
#3q
Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('12/03/2024', '%d/%m/%Y'), #12
  name: "Pointer Arithmetic",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int arr[5] = {10, 20, 30, 40, 50};
    int *ptr = arr;
    int sum = 0;

    for (int i = 0; i < 5; i++) {
        sum += *(ptr + i);
    }

    printf("Sum = %d\\n", sum);

    int x = 25;
    int y = 35;
    int *xptr = &x, *yptr = &y;

    *xptr = *xptr + 10;
    *yptr = *yptr - 5;

    printf("x = %d, y = %d\\n", x, y);

    return 0;
}},
question_array: [
    {question: 'What is the total sum calculated by the first part of the program? (give the number only)'},
    {question: 'What is the final value of x at the end of the program?'},
    {question: 'What is the final value of y at the end of the program?'}
],
  correct_answer_regex_array: ["^150$", "^35$", "^30$"],
  correct_answer_explanation: "The loop iterates over the array arr, summing its elements (10 + 20 + 30 + 40 + 50) to produce 150. x is initially 25. The operation *xptr = *xptr + 10; adds 10 to x, resulting in 35. y starts at 35. The operation *yptr = *yptr - 5; subtracts 5 from y, giving 30. "
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('26/03/2024', '%d/%m/%Y'), #26
  name: "Pointers",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int arr[5] = {10, 20, 30, 40, 50};
    int *ptr = arr;
    int sum = 0;

    for (int i = 0; i < 5; i++) {
        sum += *(ptr + i);
    }

    printf("Sum = %d\\n", sum);

    int x = 25;
    int y = 35;
    int *xptr = &x, *yptr = &y;

    *xptr = *xptr + 10;
    *yptr = *yptr - 5;

    printf("x = %d, y = %d\\n", x, y);

    return 0;
}},
question_array: [
    {question: 'What is the value of x+y after the line "*xptr = *xptr + 10;"?'}
],
  correct_answer_regex_array: ["^70$"],
  correct_answer_explanation: "x is modified to equal 35 after the line stated in the question, and the line that alters the value of y has not been executed yet. Therefore this is equal to 35+35, which is 70."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Arrays",
  difficulty: :MEDIUM,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int numbers[3] = {5, 10, 15};
    int *p = numbers;
    int offset = 1;

    *p = *p + 1;  
    *(p + offset) = *(p + offset) * 2;  
    p[offset + 1] = p[offset + 1] - 5;  

    printf("First = %d, Second = %d, Third = %d\\n", numbers[0], numbers[1], numbers[2]);
    
    return 0;
}},
question_array: [
    {question: 'What is the final value of the first element in the numbers array?'},
    {question: 'What is the value of the second element in the numbers array after the code execution?'}
],
  correct_answer_regex_array: ["^6$","^20$"],
  correct_answer_explanation: "The first element (*p) is incremented by 1, changing from 5 to 6. The second element (*(p + offset) where offset is 1) is doubled, changing from 10 to 20."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Arrays",
  difficulty: :MEDIUM,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int numbers[3] = {5, 10, 15};
    int *p = numbers;
    int offset = 1;

    *p = *p + 1;  
    *(p + offset) = *(p + offset) * 2;  
    p[offset + 1] = p[offset + 1] - 5;  

    printf("First = %d, Second = %d, Third = %d\\n", numbers[0], numbers[1], numbers[2]);
    
    return 0;
}},
question_array: [
    {question: 'What is the value of the second element in the numbers array after the code execution?'}
],
  correct_answer_regex_array: ["^20$"],
  correct_answer_explanation: "The second element (*(p + offset) where offset is 1) is doubled, changing from 10 to 20."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Arrays",
  difficulty: :MEDIUM,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    int numbers[3] = {5, 10, 15};
    int *p = numbers;
    int offset = 1;

    *p = *p + 1;  
    *(p + offset) = *(p + offset) * 2;  
    p[offset + 1] = p[offset + 1] - 5;  

    printf("First = %d, Second = %d, Third = %d\\n", numbers[0], numbers[1], numbers[2]);
    
    return 0;
}},
question_array: [
    {question: 'What does the third element of the array become at the end of the program?'}
],
  correct_answer_regex_array: ["^10$"],
  correct_answer_explanation: "5 is subtracted from the third element (p[offset + 1]), changing it from 15 to 10."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('14/03/2024', '%d/%m/%Y'), #14
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

    printf("First = %d, Second = %d, Third = %d", numbers[0], numbers[1], numbers[2]);
    
    return 0;
}},
question_array: [
    {question: 'What is the output of the printf statement?'},
    {question: 'If the value of offset is changed to 2, what will be the new value of the second element after execution?'}
],
  correct_answer_regex_array: ["^First = 6, Second = 20, Third = 10$", "^10$"],
  correct_answer_explanation: "The output reflects the final values of the array elements after the modifications. Changing offset to 2 would modify the third element instead of the second one in the line *(p + offset) = *(p + offset) * 2;. Thus, the second element remains unaltered at 10."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('15/03/2024', '%d/%m/%Y'), #15
  name: "Pointers",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    char chars[4] = {'A', 'B', 'C', 'D'};
    char *ptr = chars;
    
    ptr += 2;
    *ptr = 'Z';
    
    printf("%c, %c\\n", chars[1], *ptr);

    int numbers[] = {1, 2, 3, 4};
    int *numPtr = numbers;
    numPtr += 3; 
    *numPtr = *numPtr + 5;
    
    printf("%d\\n", numbers[3]);

    return 0;
}},
question_array: [
    {question: 'What is the new value of the character at the third position in the chars array?'},
    {question: 'What character is printed first by the printf statement?'},
    {question: 'What is the value of *ptr directly after ptr is incremented (before the value it points to is changed)?'}
],
  correct_answer_regex_array: ["^Z$", "^B$", "^C$"],
  correct_answer_explanation: "The pointer ptr is moved 2 positions ahead, pointing to 'C', and changes it to 'Z'.  The printf statement first prints chars[1], which remains unchanged as 'B'.  After incrementing ptr by 2, it points to the third element, which is C."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('16/03/2024', '%d/%m/%Y'), #16
  name: "Pointers",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    char chars[4] = {'A', 'B', 'C', 'D'};
    char *ptr = chars;
    
    ptr += 2;
    *ptr = 'Z';
    
    printf("%c, %c\\n", chars[1], *ptr);

    int numbers[] = {1, 2, 3, 4};
    int *numPtr = numbers;
    numPtr += 3; 
    *numPtr = *numPtr + 5;
    
    printf("%d\\n", numbers[3]);

    return 0;
}},
question_array: [
    {question: 'What is the final value printed for the last element in the numbers array?'},
    {question: 'If the pointer numPtr is decremented by 2 positions after the increment operation, what integer value does it point to now?'}
],
  correct_answer_regex_array: ["^9$", "^2$"],
  correct_answer_explanation: "The pointer numPtr is moved to point to the last element (4) and then increments it by 5, resulting in 9. After the increment, numPtr points to the last element (9 after modification). Decreasing it by 2 points it to the second element of the array, which is 2."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('19/03/2024', '%d/%m/%Y'), #19
  name: "Bit-wise Operators",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    unsigned int a = 12; 
    unsigned int b = 5;  
    unsigned int result;

    result = a & b; 
    printf("a & b = %u\\n", result);

    result = a | b; 
    printf("a | b = %u\\n", result);

    return 0;
}},
question_array: [
    {question: 'What is the output of the bit-wise AND operation between a and b?'}
],
  correct_answer_regex_array: ["^4$"],
  correct_answer_explanation: "The bit-wise AND operation between 12 (1100 in binary) and 5 (0101 in binary) results in 4 (0100 in binary). "
)

Challenge::CodeOutput.find_or_create_by!( 
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'), 
  name: "Bit-wise Operators",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    unsigned int a = 12; 
    unsigned int b = 5;  
    unsigned int result;

 
    result = a & b; 
    printf("a & b = %u\\n", result);

 
    FILE *file = fopen("result.txt", "w");
    if (file == NULL) {
        printf("Error opening file!\\n");
        return 1;
    }
    fprintf(file, "%u", result);
    fclose(file);

    result = a | b; 
    printf("a | b = %u\\n", result);

    return 0;
}},
question_array: [
    {question: 'What value is written to the file result.txt?'},
    {question: 'Assuming the file result.txt is successfully opened and written to, what will its content be after executing the bit-wise OR operation?'}
],
  correct_answer_regex_array: ["^4$", "^4$"],
  correct_answer_explanation: "The result of the bit-wise AND operation (4) is written to the file. The file writing operation occurs after the bit-wise AND operation, not the OR operation. The value written to the file is the result of the AND operation, not the subsequent OR operation. "
)


Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('27/03/2024', '%d/%m/%Y'), #27
  name: "Bit-wise Operators",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    unsigned int a = 12; 
    unsigned int b = 5;  
    unsigned int result;

    
    result = a & b;
    printf("a & b = %u\\n", result);
 
    result = a | b; 
    printf("a | b = %u\\n", result);

    return 0;
}},
question_array: [
    {question: 'What is the output of the bit-wise OR operation between a and b?'},
    {question: 'If a is changed to 9 and b remains 5, what is the new output of the bit-wise AND operation?'}
],
  correct_answer_regex_array: ["^13$", "^1$"],
  correct_answer_explanation: "The bit-wise OR operation between 12 (1100 in binary) and 5 (0101 in binary) results in 13 (1101 in binary)."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('17/03/2024', '%d/%m/%Y'), #17
  name: "Arithmetic",
  difficulty: :EASY,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int add(int a, int b) {
    return a + b;
}

int main() {
    int num1 = 10;
    int num2 = 20;
    int sum = add(num1, num2);
    printf("The sum is: %d\\n", sum);
    return 0;
}},
question_array: [
    {question: 'What is the value of num1?'},
    {question: 'What is the value of num2?'}
],
  correct_answer_regex_array: ["^10$", "^20$"],
  correct_answer_explanation: "num1 is initialized to 10 at the beginning of the main function, along with num2 being initialized to 20."
)


Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('08/03/2024', '%d/%m/%Y'), #8
  name: "Arithmetic",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int add(int a, int b) {
    return a + b;
}

int main() {
    int num1 = 10;
    int num2 = 20;
    int sum = add(num1, num2);
    printf("The sum is: %d\\n", sum);
    return 0;
}},
question_array: [
    {question: 'What value does the add function return when passed num1 and num2?'},
    {question: 'What is the output of the printf statement?'},
    {question: 'What is the return value of the main function?'}
],
  correct_answer_regex_array: ["^30$", "^The sum is: 30$","^0$"],
  correct_answer_explanation: "The add function returns the sum of num1 and num2 (10 + 20). The printf function outputs the sum of num1 and num2. The main function returns 0, indicating that the program executed successfully."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('18/03/2024', '%d/%m/%Y'), #18
  name: "For Loops",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>
#define MAX_VALUE 5

int main() {
    int sum = 0;
    for (int i = 1; i <= MAX_VALUE; i++) {
        switch(i) {
            case 1:
                sum += i;  
                break;
            case 3:
                sum += i * 2;  
                break;
            case 5:
                sum += i * 3;  
                break;
            default:
                sum += i;  
                break;
        }
    }
    printf("Sum = %d\\n", sum);
    return 0;
}},
question_array: [
    {question: 'What is the final value of sum after the loop completes?'},
    {question: 'How many times is the default case executed in the switch statement?'}
],
  correct_answer_regex_array: ["^28$", "^2$"],
  correct_answer_explanation: "The sum is calculated as 1 (case 1) + 2 (default for 2) + 6 (double 3 for case 3) + 4 (default for 4) + 15 (triple 5 for case 5), which totals 28. The default case is executed for the values of i that are 2 and 4. "
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "For Loops",
  difficulty: :MEDIUM,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>
#define MAX_VALUE 5

int main() {
    int sum = 0;
    for (int i = 1; i <= MAX_VALUE; i++) {
        switch(i) {
            case 1:
                sum += i;  
                break;
            case 3:
                sum += i * 2;  
                break;
            case 5:
                sum += i * 3; 
                break;
            default:
                sum += i; 
                break;
        }
    }
    printf("Sum = %d\\n", sum);
    return 0;
}},
question_array: [
    {question: 'What is the value added to sum when i is 3?'}
],
  correct_answer_regex_array: ["^6$"],
  correct_answer_explanation: "When i is 3, the case is to double i (3 * 2), resulting in 6 being added to sum."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "For Loops",
  difficulty: :MEDIUM,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>
#define MAX_VALUE 5

int main() {
    int sum = 0;
    for (int i = 1; i <= MAX_VALUE; i++) {
        switch(i) {
            case 1:
                sum += i;  
                break;
            case 3:
                sum += i * 2; 
                break;
            case 5:
                sum += i * 3;
                break;
            default:
                sum += i;
                break;
        }
    }
    printf("Sum = %d\\n", sum);
    return 0;
}},
question_array: [
    {question: 'If MAX_VALUE is changed to 6, what will be the new output for sum?'}
],
  correct_answer_regex_array: ["^34$"],
  correct_answer_explanation: "With MAX_VALUE as 6, the additional loop iteration adds 6 to the previous total of 28, resulting in 34."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "For Loops",
  difficulty: :MEDIUM,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>
#define MAX_VALUE 5

int main() {
    int sum = 0;
    for (int i = 1; i <= MAX_VALUE; i++) {
        switch(i) {
            case 1:
                sum += i;  
                break;
            case 3:
                sum += i * 2; 
                break;
            case 5:
                sum += i * 3;
                break;
            default:
                sum += i; 
                break;
        }
    }
    printf("Sum = %d\\n", sum);
    return 0;
}},
question_array: [
    {question: 'How many iterations does the for loop execute?'}
],
  correct_answer_regex_array: ["^5$"],
  correct_answer_explanation: "The loop iterates from 1 to MAX_VALUE (5), inclusive, resulting in 5 iterations."
)

Challenge::CodeOutput.find_or_create_by!( 
  date_when_available: Date.strptime('23/03/2024', '%d/%m/%Y'), #23 
  name: "Variables",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

typedef struct {
    int floors;
    float width;
    char material[50];
} Building;

int main() {
    Building b;
    printf("Enter the number of floors: ");
    scanf("%d", &b.floors);
    printf("Enter the width of the building: ");
    scanf("%f", &b.width);
    printf("Enter the building material: ");
    scanf("%s", b.material);   

    printf("Building: %d floors, %f width, made of %s\\n", b.floors, b.width, b.material);
    return 0;
}},
question_array: [
    {question: 'What is the data type of floors in the Building structure?'},
    {question: 'If the user inputs 10 for the number of floors, what value is stored in b.floors?'},
    {question: 'How many bytes are allocated for material in the Building structure?'},
    {question: 'What format specifier is used for width in the printf statement?'},
    {question: 'If the width entered is 15.5, what is the output for the width in the printf statement?'}
],
  correct_answer_regex_array: ["^int$", "^10$", "^50$","^%f$", "^15.500000$"],
  correct_answer_explanation: "In the Building structure, floors is declared as an integer type. The value entered by the user (10) is directly stored in b.floors using scanf. The material array in the Building structure is allocated 50 bytes, one for each character in the array. 
  The %f format specifier is used for floating-point numbers, which is the type of width. The printf function, when using %f, outputs floating-point numbers with six digits after the decimal by default."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('27/03/2024', '%d/%m/%Y'), #27
  name: "Buffer Overflow",
  difficulty: :HARD,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

typedef struct {
    int floors;
    float width;
    char material[50];
} Building;

int main() {
    Building b;
    printf("Enter the number of floors: ");
    scanf("%d", &b.floors);
    printf("Enter the width of the building: ");
    scanf("%f", &b.width);
    printf("Enter the building material: ");
    scanf("%s", b.material);  

    printf("Building: %d floors, %f width, made of %s\\n", b.floors, b.width, b.material);
    return 0;
}},
question_array: [
    {question: 'Will there be a buffer overflow if a string of 50 characters is entered for the building material? (Enter precisely yes or no - do not include capitals)'}
],
  correct_answer_regex_array: ["^yes$"],
  correct_answer_explanation: "For a 50-character array in C, you can safely store 49 characters plus the null terminator \0. If you attempt to store 50 characters without accounting for the null terminator, it will indeed cause a buffer overflow, as there won't be space allocated for \0 to signify the end of the string."
)

Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('28/03/2024', '%d/%m/%Y'), #28
  name: "For Loops",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    char c = 'A';
    int num = 5;
    if (num > 3) {
        c = 'B';
    }

    for (int i = 0; i < num; i++) {
        printf("%c ", c);
    }

    return 0;
}},
question_array: [
    {question: 'What character is stored in c after the if statement?'},
    {question: 'How many times is the printf statement executed?'},
    {question: 'What is the output of the program?'},
    {question: 'If num is changed to 3, what will be the new output?'}
],
  correct_answer_regex_array: ["^B$", "^5$","^B B B B B $", "^A A A $"],
  correct_answer_explanation: "Since num is greater than 3, the if statement executes, changing c from 'A' to 'B'. The loop iterates from 0 to 4 (inclusive), which is 5 times, corresponding to the value of num.
  Since c is 'B' and the loop prints it 5 times, the output is five 'B' characters separated by spaces. If num is 3, the condition num > 3 is false, so c remains 'A'. The loop executes three times, printing 'A A A '. This combines concepts of conditionals and loops. "
)


Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('24/03/2024', '%d/%m/%Y'), #24
  name: "For Loops",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>

int main() {
    char c = 'A';
    int num = 5;
    if (num > 3) {
        c = 'B';
    }

    for (int i = 0; i < num; i++) {
        printf("%c ", c);
    }

    return 0;
}},
question_array: [
    {question: 'What is the final value of the loop variable i after the loop completes?'},
    {question: 'What would be the output if the initial value of c is changed to "C" and num is set to 2?'}
],
  correct_answer_regex_array: ["^5$", "^C C $"],
  correct_answer_explanation: "After the loop completes, i is incremented to 5, which breaks the loop condition. With c starting at 'C' and num set to 2, the condition num > 3 is false, so c remains 'C'. The loop executes twice, printing 'C C'. "
)

Challenge::CodeOutput.find_or_create_by!( 
  date_when_available: Date.strptime('20/03/2024', '%d/%m/%Y'), #20
  name: "String Concatenation",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>
#include <string.h>

int main() {
    char str1[20] = "Hello";
    char str2[] = "World";
    strcat(str1, str2);

    printf("%s\\n", str1);
    int length = strlen(str1);

    for(int i = 0; i < length; i++) {
        if(str1[i] == 'o') {
            str1[i] = 'a';
        }
    }

    printf("%s\\n", str1);
    return 0;
}},
question_array: [
    {question: 'After concatenation, what is the content of str1? (do not put any " in your answer)'},
    {question: 'What is the length of str1 after concatenation?'},
    {question: 'How many times is the loop executed?'}
],
  correct_answer_regex_array: ["^HelloWorld$", "^10$", "^10$"],
  correct_answer_explanation: "strcat concatenates str2 to str1, resulting in 'HelloWorld'. After concatenation, str1 contains 10 characters, which is determined by strlen. The loop iterates equal to the length of str1, which is 10."
)


Challenge::CodeOutput.find_or_create_by!(
  date_when_available: Date.strptime('23/03/2024', '%d/%m/%Y'), #23
  name: "String Concatenation",
  difficulty: :EXTREME,
  question_overview: "Analyze the following C code and answer the questions",
  code: %Q{#include <stdio.h>
#include <string.h>

int main() {
    char str1[20] = "Hello";
    char str2[] = "World";
    strcat(str1, str2);

    printf("%s\\n", str1);
    int length = strlen(str1);

    for(int i = 0; i < length; i++) {
        if(str1[i] == 'o') {
            str1[i] = 'a';
        }
    }

    printf("%s\\n", str1);
    return 0;
}},
question_array: [
    {question: 'If str2 was "Coders", what would be the final output?'}
],
  correct_answer_regex_array: ["^HellaCaders$"],
  correct_answer_explanation: "Concatenating 'Coders' to 'Hello' results in 'HelloCoders'. The loop then changes 'o' to 'a', resulting in 'HellaCaders'."

)
