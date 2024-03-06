

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('18/03/2024', '%d/%m/%Y'), #18
  name: 'Main Function',
  difficulty: :SIMPLE,
  question_overview: "Which of the following is a correct syntax to start a main function in C?",
  answers: ["start main() {}", "function main() {}", "int main() {}", "main(): int {}"],
  correct_answer: 2,
  correct_answer_explanation: "The 'int main() {}' syntax is standard in C for defining the entry point of a program, where execution begins."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('08/03/2024', '%d/%m/%Y'), #8
  name: 'Print statements',
  difficulty: :SIMPLE,
  question_overview: "What line will print \"Hello World!\" to the console in C?",
  answers: ["print(\"Hello World!\");", "echo \"Hello World!\";", "printf(\"Hello World!\n\");", "cout << \"Hello World!\";"],
  correct_answer: 2,
  correct_answer_explanation: "printf(\"Hello World!\n\");' uses the printf function for output, displaying the string to the console."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('08/03/2024', '%d/%m/%Y'), #8
  name: 'Commentating',
  difficulty: :EASY,
  question_overview: "Which of the following demonstrates adding a single-line comment in C?",
  answers: ["// This is a comment", "<!-- This is a comment -->", "# This is a comment", "%This is a comment"],
  correct_answer: 0,
  correct_answer_explanation: "// This is a comment' is the syntax for a single-line comment in C, ignored by the compiler."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Input Output',
  difficulty: :MEDIUM,
  question_overview: "Which directive is used to include standard input and output facilities in a C program?",
  answers: ["#include \"stdio.h\"", "#include <stdio.h>", "#import <stdio.h>", "#include <iostream>"],
  correct_answer: 1,
  correct_answer_explanation: "#include <stdio.h>' is used to include the Standard Input/Output library, necessary for input/output functions."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('21/03/2024', '%d/%m/%Y'), #21
  name: 'Formatting',
  difficulty: :SIMPLE,
  question_overview: "What function is used to read a formatted input in C?",
  answers: ["scanf()", "printf()", "getchar()", "cin"],
  correct_answer: 0,
  correct_answer_explanation: "scanf()' is used for reading formatted input from the standard input (keyboard)."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('09/03/2024', '%d/%m/%Y'), #9
  name: 'Variables',
  difficulty: :SIMPLE,
  question_overview: "How do you declare an integer variable named 'age'?",
  answers: ["int age;", "int_var age;", "variable age;", "age int;"],
  correct_answer: 0,
  correct_answer_explanation: "int age;' declares an integer variable named age, using the 'int' keyword for integer data type."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('10/03/2024', '%d/%m/%Y'), # 10
  name: 'Operators',
  difficulty: :SIMPLE,
  question_overview: "Which operator is used for division in C?",
  answers: ["/", "*", "=+", "-"],
  correct_answer: 0,
  correct_answer_explanation: "The '/' operator is used for division, dividing one number by another."
)

Challenge::Scq.find_or_create_by!( 
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Loops',
  difficulty: :MEDIUM,
  question_overview: "Which loop executes at least once regardless of the condition?", 
  answers: ["do...while", "while", "for", "if"],
  correct_answer: 0,
  correct_answer_explanation: "do...while' loop is guaranteed to execute at least once because the condition is evaluated after the loop body."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('21/03/2024', '%d/%m/%Y'), #21
  name: 'Main Function',
  difficulty: :MEDIUM,
  question_overview: "What is the return type of the main function in C?",
  answers: ["int", "void", "float", "char"],
  correct_answer: 0,
  correct_answer_explanation: "int' as the return type of the main function indicates the program's exit status to the operating system, with 0 typically indicating success."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('18/03/2024', '%d/%m/%Y'), #18
  name: 'Input Output',
  difficulty: :EASY,
  question_overview: "Which header file is required for performing input/output operations?",
  answers: ["stdio.h", "stdlib.h", "math.h", "string.h"],
  correct_answer: 0,
  correct_answer_explanation: "The header file <stdio.h> is required for performing input/output operations in C, such as reading from stdin and writing to stdout."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Casting',
  difficulty: :MEDIUM,
  question_overview: "Which function converts a string to an integer?",
  answers: ["atoi()", "itos()", "stoint()", "stringToInt()"],
  correct_answer: 0,
  correct_answer_explanation: "The function atoi() converts a string to an integer, interpreting the content of the string as an integer value."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Operators',
  difficulty: :MEDIUM,
  question_overview: "What does the '&&' operator represent?",
  answers: ["Logical AND", "Bitwise AND", "Logical OR", "Bitwise OR"],
  correct_answer: 0,
  correct_answer_explanation: "The '&&' operator represents the logical AND operation, which returns true if both operands are true and false otherwise."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('12/03/2024', '%d/%m/%Y'), #12
  name: 'Loops',
  difficulty: :EASY,
  question_overview: "Which keyword is used to exit a loop prematurely?",
  answers: ["break", "continue", "exit", "return"],
  correct_answer: 0,
  correct_answer_explanation: "The keyword 'break' is used to exit a loop prematurely, immediately terminating the loop's execution."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('11/03/2024', '%d/%m/%Y'), #11
  name: 'Data types',
  difficulty: :SIMPLE,
  question_overview: "What data type is used to store a single character?",
  answers: ["char", "string", "int", "bool"],
  correct_answer: 0,
  correct_answer_explanation: "The data type 'char' is used to store a single character in C programming."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('10/03/2024', '%d/%m/%Y'), #10
  name: 'Memory',
  difficulty: :HARD,
  question_overview: "How do you allocate memory dynamically for an array of 10 integers?",
  answers: ["malloc(10 * sizeof(int))", "new int[10]", "int malloc[10]", "allocate(10)"],
  correct_answer: 0,
  correct_answer_explanation: "Memory for an array can be dynamically allocated using the malloc function, which allows for flexible array sizes at runtime."
)


Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('12/03/2024', '%d/%m/%Y'), #12
  name: 'Operators',
  difficulty: :MEDIUM,
  question_overview: "What operator is used to access a member of a structure?",
  answers: [".", "->", ":", "#"],
  correct_answer: 0,
  correct_answer_explanation: "The '.' (dot) operator is used to access a member of a structure variable."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('19/03/2024', '%d/%m/%Y'), #19
  name: 'Outputs',
  difficulty: :EASY,
  question_overview: "What is the output of 'printf(\"%d\"5 > 3);'?",
  answers: ["1", "5", "5>3", "true"],
  correct_answer: 0,
  correct_answer_explanation: "The output of 'printf(\"%d\", 5 > 3);' is '1', as the expression (5 > 3) evaluates to true, and true is represented by '1' in C."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('19/03/2024', '%d/%m/%Y'), #19
  name: 'Loops',
  difficulty: :SIMPLE,
  question_overview: "Which loop is best for iterating over an array?",
  answers: ["for", "while", "do...while", "switch"],
  correct_answer: 0,
  correct_answer_explanation: "The 'for' loop is best suited for iterating over an array when the number of iterations is known."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Arrays',
  difficulty: :MEDIUM,
  question_overview: "How do you read a string into a character array?",
  answers: ["scanf(\"%s\",str);", "getString(str);", "read(str);", "input(str);"],
  correct_answer: 0,
  correct_answer_explanation: "A string can be read into a character array using the scanf function with the %s format specifier."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('22/03/2024', '%d/%m/%Y'), #22
  name: 'Files',
  difficulty: :MEDIUM,
  question_overview: "How do you correctly open a file for only writing?",
  answers: ["fopen(\"file.txt\",w)", "openFile(\"file.txt\")", "writeFile(\"file.txt\")", "createFile(\"file.txt\",w)"],
  correct_answer: 0,
  correct_answer_explanation: "A file can be opened for writing using the fopen function with the 'w' mode specified."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('22/03/2024', '%d/%m/%Y'), #22
  name: 'Input Output',
  difficulty: :EASY,
  question_overview: "Which directive includes the standard input output library?",
  answers: ["#include <stdio.h>", "import stdio.h", "using namespace std;", "#include \"stdio.h\""],
  correct_answer: 0,
  correct_answer_explanation: "The directive '#include <stdio.h>' includes the standard input and output library, which contains printf and scanf."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('17/03/2024', '%d/%m/%Y'), #17
  name: 'Operators',
  difficulty: :SIMPLE,
  question_overview: "What does the increment operator '++' do?",
  answers: ["Increases value by 1", "Doubles the value", "Decreases value by 1", "Adds 2 to the value"],
  correct_answer: 0,
  correct_answer_explanation: "The increment operator '++' increases the value of a variable by one."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('13/03/2024', '%d/%m/%Y'), #13
  name: 'Switch Statement',
  difficulty: :MEDIUM,
  question_overview: "In which scenario do you use 'switch' statement?",
  answers: ["Multiple case checks", "Single condition check", "Loop iteration", "Function declaration"],
  correct_answer: 0,
  correct_answer_explanation: "A 'switch' statement is used for making decisions based on the value of a variable, typically an int or char."
)

Challenge::Scq.find_or_create_by!( 
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Arrays',
  difficulty: :MEDIUM,
  question_overview: "How is a multi-dimensional array declared in C?",
  answers: ["int arr[3][4];", "int arr[];", "int arr[3,4];", "int arr[][];"],
  correct_answer: 0,
  correct_answer_explanation: "A multi-dimensional array is declared by specifying each dimension's size with square brackets, e.g., int arr[3][4]; for a 2D array."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Pointers',
  difficulty: :EASY,
  question_overview: "What is the correct syntax for a pointer declaration?",
  answers: ["int *ptr;", "pointer int *;", "int ptr*;", "*int ptr;"],
  correct_answer: 0,
  correct_answer_explanation: "A pointer declaration includes the data type of the variable it points to, followed by an asterisk (*) and the pointer's name."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Loops',
  difficulty: :MEDIUM,
  question_overview: "How do you make an infinite loop using 'for'?",
  answers: ["for(;;)", "for(0)", "for(true)", "while(true)"],
  correct_answer: 0,
  correct_answer_explanation: "An infinite loop using 'for' can be created by omitting the condition, e.g., for(;;)."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Memory',
  difficulty: :HARD,
  question_overview: "What is a characteristic of dynamic memory allocation?",
  answers: ["Memory is managed at runtime", "Allocates static memory size", "Memory cannot be freed", "Allocates constant memory"],
  correct_answer: 0,
  correct_answer_explanation: "Dynamic memory allocation allows variables to be allocated memory at runtime, but it must be manually managed to avoid leaks."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Operator',
  difficulty: :EASY,
  question_overview: "Which operator is used for referencing a variable address?",
  answers: ["*", "&", "->", "."],
  correct_answer: 1,
  correct_answer_explanation: "The '&' operator is used for referencing, i.e., obtaining the memory address of a variable."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Strings',
  difficulty: :MEDIUM,
  question_overview: "How to concatenate two strings in C?",
  answers: ["strcat(s1,s2)", "concat(s1,s2)", "s1 + s2", "s1.append(s2)"],
  correct_answer: 0,
  correct_answer_explanation: "Two strings can be concatenated using the strcat function from the string.h library which is then stored within the first variable."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('26/03/2024', '%d/%m/%Y'), #26
  name: 'Headers',
  difficulty: :MEDIUM,
  question_overview: "Which header file is needed for memory allocation functions?",
  answers: ["stdlib.h", "memory.h", "alloc.h", "stdio.h"],
  correct_answer: 0,
  correct_answer_explanation: "The header file <stdlib.h> is needed for memory allocation functions such as malloc and free."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('26/03/2024', '%d/%m/%Y'), #26
  name: 'Main Function', 
  difficulty: :SIMPLE,
  question_overview: "What does 'return 0;' indicate in the main function?",
  answers: ["Program executed successfully", "Program failed", "Returns zero to caller", "Exits the program immediately"],
  correct_answer: 0,
  correct_answer_explanation: "return 0;' in the main function indicates successful program execution to the operating system."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('20/03/2024', '%d/%m/%Y'), #20
  name: 'Loops',
  difficulty: :SIMPLE,
  question_overview: "What keyword creates a loop that executes as long as a condition is true?",
  answers: ["while", "loop", "repeat", "if"],
  correct_answer: 0,
  correct_answer_explanation: "The 'while' keyword creates a loop that executes as long as its condition remains true."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('20/03/2024', '%d/%m/%Y'), #20
  name: 'Data types',
  difficulty: :EASY,
  question_overview: "Which data type is best for storing large integers?",
  answers: ["long long", "int", "short", "double"],
  correct_answer: 0,
  correct_answer_explanation: "The 'long long int' data type is best for storing large integers that exceed the range of standard int types."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'String copying',
  difficulty: :MEDIUM,
  question_overview: "What C library function copies a string?",
  answers: ["strcpy()", "copyStr()", "strCpy()", "cloneString()"],
  correct_answer: 0,
  correct_answer_explanation: "The strcpy function from the string.h library is used to copy one string to another."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('24/03/2024', '%d/%m/%Y'), #24
  name: 'Commenting',
  difficulty: :EASY,
  question_overview: "How do you start a block comment in C?",
  answers: ["/*", "//", "<!--", "#"],
  correct_answer: 0,
  correct_answer_explanation: "A block comment in C starts with /* and ends with */, encompassing multiple lines of text if needed."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('24/03/2024', '%d/%m/%Y'), #24
  name: 'Libraries',
  difficulty: :MEDIUM,
  question_overview: "Which C standard library function calculates the square root?",
  answers: ["sqrt()", "pow()", "squareRoot()", "root()"],
  correct_answer: 0,
  correct_answer_explanation: "The sqrt function from the math.h library calculates the square root of a given number."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('14/03/2024', '%d/%m/%Y'), #14
  name: 'Function',
  difficulty: :SIMPLE,
  question_overview: "Which keyword is used to return from a function?",
  answers: ["return", "exit", "break", "continue"],
  correct_answer: 0,
  correct_answer_explanation: "The 'return' keyword is used to exit a function, optionally returning a value to the caller."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('14/03/2024', '%d/%m/%Y'), #14
  name: 'Macro',
  difficulty: :EASY,
  question_overview: "How to define a macro in C?",
  answers: ["#define PI 3.14", "define PI 3.14", "const double PI = 3.14", "macro PI 3.14"],
  correct_answer: 0,
  correct_answer_explanation: "A macro in C is defined using the '#define' directive, allowing the creation of constant values or macro functions."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('15/03/2024', '%d/%m/%Y'), #15
  name: 'Printing',
  difficulty: :SIMPLE,
  question_overview: "What is the standard method for printing to console?",
  answers: ["printf()", "print()", "cout <<", "write()"],
  correct_answer: 0,
  correct_answer_explanation: "The standard method for printing to console in C is using the printf function from the stdio.h library."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('16/03/2024', '%d/%m/%Y'), #16
  name: 'Operators',
  difficulty: :MEDIUM,
  question_overview: "Which operator is used to access members of a pointer to a structure?",
  answers: ["->", ".", "::", "&"],
  correct_answer: 0,
  correct_answer_explanation: "The '->' operator is used to access members of a structure or union through a pointer."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Header files',
  difficulty: :MEDIUM,
  question_overview: "What header file provides functions for string manipulation?",
  answers: ["string.h", "strings.h", "stdio.h", "strlib.h"],
  correct_answer: 0,
  correct_answer_explanation: "The <string.h> header file is included for functions that manipulate null-terminated strings."
)

Challenge::Scq.find_or_create_by!(
  date_when_available:  Date.strptime('24/03/2024', '%d/%m/%Y'), #24
  name: 'Structure definition',
  difficulty: :SIMPLE,
  question_overview: "How is a structure defined in C?",
  answers: ["struct MyStruct {}", "define struct MyStruct {}", "class MyStruct {}", "structure MyStruct {};"],
  correct_answer: 0,
  correct_answer_explanation: "A structure in C is defined using the 'struct' keyword, allowing the grouping of variables under a single name."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Header files',
  difficulty: :MEDIUM,
  question_overview: "In C, which header file is required to use the 'qsort' function?",
  answers: ["stdlib.h", "stdio.h", "math.h", "string.h"],
  correct_answer: 0,
  correct_answer_explanation: "The ceil function from the math.h library rounds a floating-point number up to the nearest integer."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Bitwise Operations',
  difficulty: :MEDIUM,
  question_overview: "How do you perform a bitwise AND operation on two variables a and b in C?",
  answers: ["a & b", "a && b", "a and b", "AND(a, b)"],
  correct_answer: 0,
  correct_answer_explanation: "The '&' operator is used for bitwise AND operation between two integers in C."
)

Challenge::Scq.find_or_create_by!( 
  date_when_available: Date.strptime('25/03/2024', '%d/%m/%Y'), #25
  name: 'File reading and writing',
  difficulty: :HARD,
  question_overview: "Which function is used to open a file for both reading and writing in C?",
  answers: ["fopen() with mode 'r+'", "fopen() with mode 'w'", "fopen() with mode 'a'", "open() with mode 'rw'"],
  correct_answer: 0,
  correct_answer_explanation: "fopen() with mode 'r+' opens a file for both reading and writing."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Casting',
  difficulty: :MEDIUM,
  question_overview: "What is the result of casting a float to an int in C when the float is 3.9?",
  answers: ["3", "4", "3.0", "4.0"],
  correct_answer: 0,
  correct_answer_explanation: "Casting a float to an int truncates the decimal part, resulting in 3."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Pointers',
  difficulty: :HARD,
  question_overview: "How do you access the value stored in the address a pointer points to in C?",
  answers: ["&ptr", "*ptr", "ptr*", "ptr&"],
  correct_answer: 1,
  correct_answer_explanation: "The '*' operator is used before a pointer variable to access the value stored in the address it points to."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Bitwise operators',
  difficulty: :HARD,
  question_overview: "Which bitwise operator is used for shifting bits to the left, filling the right with zeros?",
  answers: ["<<", ">>", "&<<", "|<<"],
  correct_answer: 0,
  correct_answer_explanation: "The '<<' operator shifts bits to the left, filling the right with zeros."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Bitwise operators',
  difficulty: :HARD,
  question_overview: "Which operator is used to invert all bits in an integer variable 'a' in C?",
  answers: ["~a", "!a", "=-a", "^a"],
  correct_answer: 0,
  correct_answer_explanation: "The '~' operator is used to perform bitwise NOT operation, inverting all bits of its operand."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Reading files',
  difficulty: :HARD,
  question_overview: "How do you read a string from a file until a newline is encountered using fgets in C?",
  answers: ["fgets(str, MAX, file)", "fgets(file, str, MAX)", "fgets(MAX, file, str)", "fgets(file, MAX, str)"],
  correct_answer: 0,
  correct_answer_explanation: "The correct usage of fgets to read a string from a file is fgets(str, MAX, file), where str is the string variable, MAX is the maximum number of characters to read, and file is the file pointer."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'sizeof Operator',
  difficulty: :HARD,
  question_overview: "What does the sizeof operator in C return when applied to a pointer type?",
  answers: ["The size of the data type the pointer points to", "The size of the pointer itself", "The size of memory block allocated by the pointer", "The length of the array the pointer points to"],
  correct_answer: 1,
  correct_answer_explanation: "The sizeof operator returns the size of the pointer itself, not the size of the data type or memory block it points to."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'strtok Library',
  difficulty: :MEDIUM,
  question_overview: "In C, what does the standard library function 'strtok' do?",
  answers: ["Tokenizes a string", "Sorts a string", "Compares two strings", "Copies a string"],
  correct_answer: 0,
  correct_answer_explanation: "The library 'strtok' has the functionality to tokenize strings."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('27/03/2024', '%d/%m/%Y'), #27
  name: 'Prefix',
  difficulty: :EASY,
  question_overview: "What does the '0x' prefix signify in C?",
  answers: ["Binary number", "Octal number", "Decimal number", "Hexadecimal number"],
  correct_answer: 3,
  correct_answer_explanation: "0x Represents a decimal number"
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('27/03/2024', '%d/%m/%Y'), #27
  name: 'Headers',
  difficulty: :SIMPLE,
  question_overview: "Which header file is required to use the 'printf' and 'scanf' functions in C?",
  answers: ["stdio.h", "stdlib.h", "string.h", "math.h"],
  correct_answer: 0,
  correct_answer_explanation: "The stdio.h is the header file that includes the functions printf and scanf"
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('28/03/2024', '%d/%m/%Y'), #28
  name: 'Memory',
  difficulty: :EASY,
  question_overview: "What is the return type of the 'malloc' or 'calloc' functions in C?",
  answers: ["int *", "float *", "void *", "char *"],
  correct_answer: 2,
  correct_answer_explanation: "The return types are void *"
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('25/03/2024', '%d/%m/%Y'), #25
  name: 'Memory',
  difficulty: :SIMPLE,
  question_overview: "Which function is used to deallocate memory in C?",
  answers: ["free", "dealloc", "memory_free", "release"],
  correct_answer: 0,
  correct_answer_explanation: "Free is used to deallocate memory slots in C"
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('28/03/2024', '%d/%m/%Y'), #28
  name: 'Arrays',
  difficulty: :MEDIUM,
  question_overview: "What is the correct syntax to declare an array of pointers in C?",
  answers: ["int *arr[]", "int arr*[]", "*arr int[]", "int []*arr"],
  correct_answer: 0,
  correct_answer_explanation: "The correct syntax is int *arr[]"
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'C Libraries',
  difficulty: :MEDIUM,
  question_overview: "Which standard library in C provides mathematical functions?",
  answers: ["math.h", "cmath", "mathlib.h", "stdlib.h"],
  correct_answer: 0,
  correct_answer_explanation: "'math.h' is the library in C that provides mathematical functions."
)

Challenge::Scq.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: 'Multi-dimensional arrays',
  difficulty: :MEDIUM,
  question_overview: "How is a multi-dimensional array accessed in C?",
  answers: ["Using multiple indices", "Using a single index", "Using pointer arithmetic", "Using commas between indices"],
  correct_answer: 0,
  correct_answer_explanation: "To access a specifc element in a multi-dimensional array, multiple indices are needed to specify which array the element is in, and then the position of the element in the array itself."
)

