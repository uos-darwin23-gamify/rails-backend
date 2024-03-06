Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('17/03/2024', '%d/%m/%Y'), #17
  name: "C Data Types",
  difficulty: :EASY,
  question_overview: "Which of the following are primitive data types in C?",
  answers: ['int', 'float', 'char', 'string'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "In C, `int`, `float`, and `char` are primitive data types, whereas `string` is not a primitive data type but a library type."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('08/03/2024', '%d/%m/%Y'), #---
  name: "Function Characteristics",
  difficulty: :MEDIUM,
  question_overview: "Which of the following are true about functions in C?",
  answers: ['Can return multiple values', 'Can have multiple parameters', 'Can be called recursively', 'Can be nested'],
  correct_answers: [1, 2],
  correct_answer_explanation: "Functions in C can have multiple parameters and can be called recursively. They cannot return multiple values directly and cannot be nested."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('15/03/2024', '%d/%m/%Y'), #15
  name: "Pointer Concepts",
  difficulty: :HARD,
  question_overview: "Which of the following statements are true regarding pointers in C?",
  answers: ['Pointers can point to another pointer', 'Pointers can point to functions', 'Pointers increase program execution speed', 'Pointers can be used to access array elements'],
  correct_answers: [0, 1, 3],
  correct_answer_explanation: "Pointers can indeed point to another pointer, point to functions, and be used to access array elements. While pointers can optimize memory usage, they don't inherently increase execution speed."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('18/03/2024', '%d/%m/%Y'), #18
  name: "Storage Class Specifiers",
  difficulty: :HARD,
  question_overview: "Which of the following are storage class specifiers in C?",
  answers: ['auto', 'register', 'volatile', 'static'],
  correct_answers: [0, 1, 3],
  correct_answer_explanation: "`auto`, `register`, and `static` are storage class specifiers in C. `volatile` is a type qualifier, not a storage class specifier."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('09/03/2024', '%d/%m/%Y'), # 09
  name: "Valid String Initializations",
  difficulty: :EASY,
  question_overview: "Which of the following are valid ways to initialize a string in C?",
  answers: ['char str[] = "Hello";', 'char *str = "Hello";', 'string str = "Hello";', 'char str[6] = "Hello";'],
  correct_answers: [0, 1, 3],
  correct_answer_explanation: "`char str[] = \"Hello\";`, `char *str = \"Hello\";`, and `char str[6] = \"Hello\";` are valid initializations for strings in C. `string str = \"Hello\";` is incorrect because `string` is not a built-in type in C."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: ,
  name: "Valid Integer Types",
  difficulty: :EASY,
  question_overview: "Which of the following are valid integer types in C?",
  answers: ['int', 'short', 'long', 'dec'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "`int`, `short`, and `long` are valid integer types in C. `dec` is not a valid type in C."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('09/03/2024', '%d/%m/%Y'), #--
  name: "Function Return Types",
  difficulty: :MEDIUM,
  question_overview: "Which of the following can be used as return types for a function in C?",
  answers: ['int', 'void', 'char *', 'struct MyStruct'],
  correct_answers: [0, 1, 2, 3],
  correct_answer_explanation: "All the options are valid return types in C. Functions can return basic data types, pointers, and structs."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('20/03/2024', '%d/%m/%Y'), #20
  name: "C Standard Library Functions",
  difficulty: :HARD,
  question_overview: "Which of the following are standard library functions in C?",
  answers: ['printf', 'scanf', 'strcpy', 'strcomp'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "`printf`, `scanf`, and `strcpy` are standard library functions in C. `strcomp` is not; the correct function is `strcmp`."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('22/03/2024', '%d/%m/%Y'), #22
  name: "Pointer Operations",
  difficulty: :EXTREME,
  question_overview: "Which of the following are valid pointer operations in C?",
  answers: ['*ptr', '&var', 'ptr++', '++*ptr'],
  correct_answers: [0, 1, 2, 3],
  correct_answer_explanation: "All the options are valid pointer operations. `*ptr` dereferences a pointer, `&var` gets the address of a variable, `ptr++` advances a pointer, and `++*ptr` increments the value pointed to by ptr."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('11/03/2024', '%d/%m/%Y'), #11
  name: "Conditional Expressions",
  difficulty: :MEDIUM,
  question_overview: "Which of the following are valid conditional expressions in C?",
  answers: ['x == y', 'x != y', 'x && y', 'x <= y'],
  correct_answers: [0, 1, 2, 3],
  correct_answer_explanation: "All the options are valid conditional expressions in C, used to compare values and determine logic flow."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('10/03/2024', '%d/%m/%Y'), #10
  name: "Valid Preprocessor Directives",
  difficulty: :MEDIUM,
  question_overview: "Which of the following are valid preprocessor directives in C?",
  answers: ['#include', '#define', '#ifdef', '#create'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "`#include`, `#define`, and `#ifdef` are valid preprocessor directives. `#create` is not a valid preprocessor directive in C."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('23/03/2024', '%d/%m/%Y'), #23
  name: "Casting in C",
  difficulty: :HARD,
  question_overview: "Which of the following is a correct way to perform casting in C?",
  answers: ['(int)x', 'int(x)', 'cast(int, x)', '(integer)x'],
  correct_answers: [0],
  correct_answer_explanation: "The correct syntax for casting in C is `(int)x`. The other options are not valid syntaxes for casting in C."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('11/03/2024', '%d/%m/%Y'), #11
  name: "String Functions",
  difficulty: :EXTREME,
  question_overview: "Which of the following are standard string manipulation functions in C?",
  answers: ['stradd', 'strcopy', 'strlen', 'strcat'],
  correct_answers: [2, 3],
  correct_answer_explanation: "`strlen` and `strcat` are standard string manipulation functions in C. `stradd` and `strcopy` do not exist in the standard library."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('19/03/2024', '%d/%m/%Y'), #19
  name: "Keywords in C",
  difficulty: :MEDIUM,
  question_overview: "Which of the following is a reserved keyword in C?",
  answers: ['main', 'class', 'int', 'function'],
  correct_answers: [2],
  correct_answer_explanation: "`int` is a reserved keyword in C used for declaring integer variables. `main`, `class`, and `function` are not reserved keywords."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('12/03/2024', '%d/%m/%Y'), #12
  name: "Memory Allocation Errors",
  difficulty: :HARD,
  question_overview: "Which of the following can be a consequence of incorrect memory allocation in C?",
  answers: ['Memory leak', 'Segmentation fault', 'Buffer overflow', 'Syntax error'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "Memory leak, segmentation fault, and buffer overflow can result from incorrect memory allocation. Syntax error is a compile-time error, not related to memory allocation."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('31/03/2024', '%d/%m/%Y'),
  name: "Loop Keywords",
  difficulty: :MEDIUM,
  question_overview: "Which of the following keywords are associated with loops in C?",
  answers: ['continue', 'break', 'return', 'exit'],
  correct_answers: [0, 1],
  correct_answer_explanation: "`continue` and `break` are keywords associated with loop control in C. `return` is used to exit functions, and `exit` is used to terminate the program."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('16/03/2024', '%d/%m/%Y'), #16
  name: "Data Types",
  difficulty: :SIMPLE,
  question_overview: "Which of the following are floating-point types in C?",
  answers: ['double', 'float', 'long double', 'int'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "`double`, `float`, and `long double` are the floating-point types in C. `int` is an integer type."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('13/03/2024', '%d/%m/%Y'), #13
  name: "Invalid Keywords",
  difficulty: :HARD,
  question_overview: "Which of the following are valid C keywords?",
  answers: ['class', 'interface', 'template', 'package'],
  correct_answers: [],
  correct_answer_explanation: "None of the listed options are valid C keywords. They are more commonly associated with other programming languages like Java or C++."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('25/03/2024', '%d/%m/%Y'), #25
  name: "Standard Library Functions",
  difficulty: :MEDIUM,
  question_overview: "Which of the following are standard library functions for dynamic memory management in C?",
  answers: ['malloc', 'alloc', 'realloc', 'free'],
  correct_answers: [0, 2, 3],
  correct_answer_explanation: "`malloc`, `realloc`, and `free` are used for dynamic memory management in C. `alloc` is not a standard C library function."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('04/04/2024', '%d/%m/%Y'),
  name: "Operating System Interaction",
  difficulty: :MEDIUM,
  question_overview: "Which of the following functions are used to interact with the operating system in C?",
  answers: ['printf', 'scanf', 'system', 'fopen'],
  correct_answers: [2],
  correct_answer_explanation: "The `system` function is used to pass commands to the operating system in C. The other functions, `printf`, `scanf`, and `fopen`, are used for input/output operations and file handling, not for interacting with the operating system."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('21/03/2024', '%d/%m/%Y'), #21
  name: "C Standard Library",
  difficulty: :EASY,
  question_overview: "Which of the following are part of the C standard library?",
  answers: ['iostream', 'conio.h', 'stdio.h', 'cobol.h'],
  correct_answers: [2],
  correct_answer_explanation: "None of the listed options, except for `stdio.h`, are part of the C standard library. `iostream` is a C++ header, while `conio.h` and `cobol.h` are not standard C library headers."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('14/03/2024', '%d/%m/%Y'), #14
  name: "File Handling Functions",
  difficulty: :HARD,
  question_overview: "Which of the following functions are used in file handling in C?",
  answers: ['fopen', 'fclose', 'fwrite', 'fscan'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "`fopen`, `fclose`, and `fwrite` are used in file handling in C. `fscan` is not a valid file handling function in C."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('15/03/2024', '%d/%m/%Y')), #15
  name: "Compiler Directives",
  difficulty: :MEDIUM,
  question_overview: "Which of the following are valid compiler directives in C?",
  answers: ['#pragma', '#define', '#include', '#version'],
  correct_answers: [0, 1, 2],
  correct_answer_explanation: "`#pragma`, `#define`, and `#include` are valid compiler directives in C. `#version` is not a standard compiler directive in C."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: ,
  name: "Variable Scope",
  difficulty: :MEDIUM,
  question_overview: "Which of the following scopes are valid in C?",
  answers: ['Local', 'Global', 'Function', 'Block'],
  correct_answers: [0, 1, 3],
  correct_answer_explanation: "Local, Global, and Block scopes are valid in C. 'Function' is not a recognized scope."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('25/03/2024', '%d/%m/%Y'), #25
  name: "Type Qualifiers",
  difficulty: :EASY,
  question_overview: "Which of the following are type qualifiers in C?",
  answers: ['static', 'volatile', 'const', 'register'],
  correct_answers: [1, 2],
  correct_answer_explanation: "`volatile` and `const` are type qualifiers in C. `static` and `register` are storage class specifiers, not type qualifiers."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('28/03/2024', '%d/%m/%Y'), #28
  name: "Input and Output Functions",
  difficulty: :SIMPLE,
  question_overview: "Which of the following functions are used for input and output in C?",
  answers: ['printf', 'scanf', 'cin', 'cout'],
  correct_answers: [0, 1],
  correct_answer_explanation: "`printf` and `scanf` are used for output and input in C, respectively. `cin` and `cout` are C++ stream objects, not C functions."
)

Challenge::Mcq.find_or_create_by!(a
  date_when_available: Date.strptime('17/03/2024', '%d/%m/%Y'), #17
  name: "Operator Evaluation",
  difficulty: :MEDIUM,
  question_overview: "Which of the following statements about pre-fix and post-fix operators are true?",
  answers: ['++x increments x before use', 'x++ increments x after use', 'x-- decrements x before use', '--x decrements x after use'],
  correct_answers: [0, 1],
  correct_answer_explanation: "`++x` and `--x` are pre-fix operators that increment/decrement before use, while `x++` increments after use. `x--` decrements after use, not before."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('27/03/2024', '%d/%m/%Y'), #27
  name: "Using #define and switch case",
  difficulty: :MEDIUM,
  question_overview: "Which of the following uses of #define and switch case are correct?",
  answers: ['#define PI 3.14', 'switch(variable) { case 1: ... }', '#define x++', 'switch(x) { #define CASE 1 }'],
  correct_answers: [0, 1],
  correct_answer_explanation: "`#define PI 3.14` correctly defines a constant, and `switch(variable) { case 1: ... }` is the proper syntax for a switch case. The other options are incorrect uses of #define and switch."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('26/03/2024', '%d/%m/%Y'), #26
  name: "Array Declaration and Initialization",
  difficulty: :EASY,
  question_overview: "Which of the following are correct ways to declare and initialize an array in C?",
  answers: ['int arr[5] = {1, 2, 3, 4, 5};', 'int arr[] = {1, 2, 3, 4, 5};', 'int arr = {1, 2, 3, 4, 5};', 'int arr[5]; arr = {1, 2, 3, 4, 5};'],
  correct_answers: [0, 1],
  correct_answer_explanation: "You can initialize an array at declaration with `int arr[5] = {1, 2, 3, 4, 5};` or `int arr[] = {1, 2, 3, 4, 5};`. The other options are incorrect."
)

Challenge::Mcq.find_or_create_by!(
  date_when_available: Date.strptime('20/04/2024', '%d/%m/%Y'),
  name: "Function Declaration and Definition",
  difficulty: :MEDIUM,
  question_overview: "Which of the following statements are true regarding functions in C?",
  answers: ['Function declarations must specify the return type', 'Functions can return any type', 'Function definitions do not need to match declarations', 'Functions in C can have default parameter values'],
  correct_answers: [0],
  correct_answer_explanation: "Function declarations must specify the return type. Functions cannot return any type; they must return a type that is specified. Definitions must match declarations, and C does not support default parameter values."
)
