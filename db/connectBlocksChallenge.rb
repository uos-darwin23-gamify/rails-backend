Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('23/03/2024', '%d/%m/%Y'), #23
  name: "Arithmetic Mastery",
  difficulty: :SIMPLE,
  question_overview: "Match the arithmetic operations in C to their outcomes",
  first_group: ["5 + 3", "10 - 4", "7 * 6", "8 / 2"],
  second_group: ["8", "6", "42", "4"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "5 + 3 equals 8, 10 - 4 equals 6, 7 * 6 equals 42, and 8 / 2 equals 4."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('23/03/2024', '%d/%m/%Y'), #23
  name: "Control Flow",
  difficulty: :MEDIUM,
  question_overview: "Match the control flow statements with their descriptions",
  first_group: ["if-else", "switch", "for loop", "while loop"],
  second_group: ["Selects one of many code blocks to execute", "Executes a block of code multiple times with an initializer", "Executes a block of code as long as a condition is true", "Branches execution based on a condition"],
  correct_answers: [[0, 3], [1, 0], [2, 1], [3, 2]],
  correct_answer_explanation: "if-else branches execution, switch selects a block to execute, for loop runs with an initializer, and while loop runs as long as a condition is true."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('10/03/2024', '%d/%m/%Y'), #10
  name: "Function Fundamentals",
  difficulty: :EASY,
  question_overview: "Match the function components to their descriptions",
  first_group: ["Return type", "Function name", "Parameters", "Function body"],
  second_group: ["Defines what the function returns", "The unique identifier of the function", "Inputs to the function", "Contains the executable code"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Return type defines the function's output, the function name is its identifier, parameters are its inputs, and the function body contains its code."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('11/03/2024', '%d/%m/%Y'), #11
  name: "Pointers and Memory",
  difficulty: :HARD,
  question_overview: "Match the pointer concepts to their explanations",
  first_group: ["Pointer declaration", "Pointer initialization", "Pointer dereferencing", "Pointer arithmetic"],
  second_group: ["Defines a pointer variable", "Assigns a memory address to a pointer", "Accesses the value at the memory address", "Performs operations on memory addresses"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Pointer declaration defines a pointer, initialization assigns it an address, dereferencing accesses the value at the address, and arithmetic performs operations on addresses."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('12/03/2024', '%d/%m/%Y'), #12
  name: "Data Types and Variables",
  difficulty: :SIMPLE,
  question_overview: "Match the data types to their descriptions",
  first_group: ["int", "char", "float", "double"],
  second_group: ["Stores integers", "Stores single characters", "Stores single-precision floating-point numbers", "Stores double-precision floating-point numbers"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "int for integers, char for characters, float for single-precision numbers, and double for double-precision numbers."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Advanced Bit Manipulation",
  difficulty: :MEDIUM,
  question_overview: "Match the bit manipulation operations with their outcomes",
  first_group: ["x << 2", "x >> 2", "~x", "x & y"],
  second_group: ["Shifts x left by 2 bits", "Shifts x right by 2 bits", "Inverts all bits of x", "Performs AND operation on x and y"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Left shift multiplies by 2 for each shift, right shift divides by 2 for each shift, bit inversion flips all bits, and bitwise AND compares bits of x and y."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('21/03/2024', '%d/%m/%Y'), #21
  name: "Complex Pointer Arithmetic",
  difficulty: :HARD,
  question_overview: "Match the pointer arithmetic operations with their descriptions",
  first_group: ["ptr + 1", "ptr - 1", "*ptr", "++ptr"],
  second_group: ["Increments pointer to point to the next memory location", "Decrements pointer to point to the previous memory location", "Dereferences the pointer to access the value", "Advances the pointer to the next element"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Pointer arithmetic allows navigation through memory, dereferencing accesses the value at the pointer's address."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'), 
  name: "Advanced Data Structures",
  difficulty: :EXTREME,
  question_overview: "Match the data structures with their characteristic operations",
  first_group: ["Binary Tree", "Linked List", "Stack", "Queue"],
  second_group: ["Hierarchical access", "Sequential access", "last-in-first-out access", "first-in-first-out access"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Binary tree for hierarchical data, linked list for linear data, stack supports last-in-first-out, and queue supports first-in-first-out."
)

Challenge::ConnectBlocks.find_or_create_by!( 
  date_when_available: Date.strptime('13/03/2024', '%d/%m/%Y'), #13
  name: "Memory Management",
  difficulty: :EXTREME,
  question_overview: "Match the memory management functions with their descriptions",
  first_group: ["malloc", "calloc", "free", "realloc"],
  second_group: ["Allocates memory without clearing", "Allocates and clears memory", "Deallocates memory", "Changes the size of allocated memory"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "malloc for allocation, calloc for allocation and initialization, free for deallocation, realloc for resizing."
)

Challenge::ConnectBlocks.find_or_create_by!( 
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'), 
  name: "Thread Management in C",
  difficulty: :EXTREME,
  question_overview: "Match the thread-related functions to their descriptions",
  first_group: ["pthread_create", "pthread_join", "pthread_exit", "pthread_cancel"],
  second_group: ["Starts a new thread", "Waits for a thread to terminate", "Exits the calling thread", "Sends a cancellation request to a thread"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "pthread_create starts a thread, pthread_join waits for a thread, pthread_exit exits a thread, and pthread_cancel requests to cancel a thread."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('13/03/2024', '%d/%m/%Y'), #13
  name: "Basic I/O Operations",
  difficulty: :EASY,
  question_overview: "Match the I/O functions to their descriptions",
  first_group: ["printf", "scanf", "putchar", "getchar"],
  second_group: ["Outputs a character to stdout", "Reads a character from stdin", "Outputs formatted string to stdout", "Reads formatted input from stdin"],
  correct_answers: [[0, 2], [1, 3], [2, 0], [3, 1]],
  correct_answer_explanation: "printf outputs formatted text, scanf reads formatted input, putchar outputs a character, getchar reads a character."
)

Challenge::ConnectBlocks.find_or_create_by!( 
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'), 
  name: "Structs and Enums",
  difficulty: :EXTREME,
  question_overview: "Match the struct and enum related terms to their descriptions",
  first_group: ["struct", "enum", "typedef", "union"],
  second_group: ["Defines a new data type", "Creates an alias for a type", "Allows one variable to store different data types", "Defines a collection of constants"],
  correct_answers: [[0, 3], [1, 0], [2, 1], [3, 2]],
  correct_answer_explanation: "struct defines a collection of consts, enum defines defines a data type, typedef creates type aliases, and union stores different data types."
)

Challenge::ConnectBlocks.find_or_create_by!( 
  date_when_available: Date.strptime('24/03/2024', '%d/%m/%Y'), #24
  name: "Preprocessor Directives",
  difficulty: :HARD,
  question_overview: "Match the preprocessor directives to their functions",
  first_group: ["#define", "#include", "#ifdef", "#pragma"],
  second_group: ["Includes a file", "Defines a macro", "Checks if a macro is defined", "Specifies compiler-specific instructions"],
  correct_answers: [[0, 1], [1, 0], [2, 2], [3, 3]],
  correct_answer_explanation: "#define creates macros, #include includes files, #ifdef checks macro definitions, and #pragma gives special instructions."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('22/03/2024', '%d/%m/%Y'), #22
  name: "Basic Syntax and Semantics",
  difficulty: :SIMPLE,
  question_overview: "Match the basic C syntax elements to their descriptions",
  first_group: [";", "{}", "//", "#include"],
  second_group: ["Marks the end of a statement", "Encloses a block of code", "Introduces a single-line comment", "Inserts the contents of a file"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "';' ends a statement, '{}' encloses blocks, '//' starts a comment, '#include' inserts files."
)

Challenge::ConnectBlocks.find_or_create_by!( 
  date_when_available: Date.strptime('16/03/2024', '%d/%m/%Y'), #16
  name: "Logical and Bitwise Operations",
  difficulty: :EASY,
  question_overview: "Match the operators to their operation types",
  first_group: ["&&", "||", "&", "|"],
  second_group: ["Logical AND", "Logical OR", "Bitwise AND", "Bitwise OR"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "'&&' is logical AND, '||' is logical OR, '&' is bitwise AND, '|' is bitwise OR."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('25/03/2024', '%d/%m/%Y'), #25
  name: "Function Overloading and Recursion",
  difficulty: :HARD,
  question_overview: "Match the concepts to their descriptions in C",
  first_group: ["Function Overloading", "Recursion", "Inline Function", "Function Pointer"],
  second_group: ["A function calls itself", "Allows multiple functions with the same name", "A pointer to a function", "Suggests to compiler to insert code directly"],
  correct_answers: [[0, 1], [1, 0], [2, 3], [3, 2]],
  correct_answer_explanation: "C doesn't support function overloading, recursion is self-calling, inline suggests code insertion, function pointers store function addresses."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('19/03/2024', '%d/%m/%Y'), #19
  name: "Advanced Data Types",
  difficulty: :HARD,
  question_overview: "Match the advanced data types to their descriptions",
  first_group: ["void pointer", "struct", "union", "enum"],
  second_group: ["Can point to any data type", "Collection of related data items", "Stores various data types in the same memory location", "Defines a set of named integer constants"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "void pointer is generic, struct groups data, union shares memory for different types, enum lists named integers."
)


# Mongoid syntax
Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Control Statements",
  difficulty: :EASY,
  question_overview: "Match the following control statements with their functionalities.",
  first_group: ["if", "else", "&&", "||"],
  second_group: ["Executes block of code if the condition is true", "Executes block of code if the if condition is false", "Used within a comparitive statement to check if both conditions are true", "Used within a comparitive statement to check if atleast one of the conditions is true"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "if for true conditions, else for false conditions, && for logical AND, || for logical OR."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('13/03/2024', '%d/%m/%Y'), #13
  name: "Type Conversions",
  difficulty: :SIMPLE,
  question_overview: "Match the type conversion examples with their descriptions.",
  first_group: ["(int)7.00", "(double)7", "(float)7", "(char)7"],
  second_group: ["Casts 7.00 to an integer", "Casts 7 to a double", "Casts 7 to a float", "Casts integer 7 to a character"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Explicit casting examples for different types."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('18/03/2024', '%d/%m/%Y'), #18
  name: "Switch Statements",
  difficulty: :MEDIUM,
  question_overview: "Match the components of a switch statement with their descriptions.",
  first_group: ["switch", "case", "break", "default"],
  second_group: ["Starts the switch statement", "Represents a branch based on a value", "Exits the switch statement", "Executes if no case matches"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "switch to initiate, case for value-based branches, break to exit, default for no match."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('20/03/2024', '%d/%m/%Y'), #20
  name: "Loops",
  difficulty: :MEDIUM,
  question_overview: "Match the loop types with their descriptions.",
  first_group: ["while", "do...while", "for"],
  second_group: ["Repeats as long as a condition is true", "Executes once, then repeats as long as condition is true", "Repeats with a counter"],
  correct_answers: [[0, 0], [1, 1], [2, 2]],
  correct_answer_explanation: "while for condition-based repetition, do...while guarantees one execution, for uses a counter"
)

Challenge::ConnectBlocks.find_or_create_by!( 
  date_when_available: Date.strptime('25/03/2024', '%d/%m/%Y'), #25
  name: "Array Operations",
  difficulty: :EXTREME,
  question_overview: "Match the array operations with their descriptions.",
  first_group: ["Declaration", "Indexing", "Initialization", "sizeof"],
  second_group: ["Defines an array and its type", "Accesses an element at a specific position", "Assigns values to an array at declaration", "Finds the size of the array"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Declaration defines type, Indexing accesses elements, Initialization assigns values, sizeof returns size."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Array and Loop Concepts",
  difficulty: :MEDIUM,
  question_overview: "Match the concepts with their correct descriptions in the context of loops and arrays.",
  first_group: ["Nested for loop", "Multi-dimensional array", "Iteration", "Array indexing"],
  second_group: ["A for loop inside another for loop", "Array of arrays", "The repetition of a block of code", "Accessing elements in an array"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Nested for loops for multi-level loops, Multi-dimensional arrays contain arrays, Iteration is code repetition, Array indexing for element access."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Function Components",
  difficulty: :MEDIUM,
  question_overview: "Match the function components with their descriptions.",
  first_group: ["Function definition", "Function declaration", "Return type", "Parameters"],
  second_group: ["Specifies what the function does", "Specifies the existence of a function", "Specifies the type of value of the result of a function", "Inputs to the function"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "Function definition provides the body, declaration introduces the function, return type specifies output type, parameters are inputs."
)

Challenge::ConnectBlocks.find_or_create_by!( 
  date_when_available: Date.strptime('26/03/2024', '%d/%m/%Y'), #26
  name: "Pointer Concepts",
  difficulty: :EXTREME,
  question_overview: "Match the pointer concepts with their correct descriptions.",
  first_group: ["*", "&", "Pointer declaration", "Pointer arithmetic"],
  second_group: ["Dereference operator", "Address-of operator", "Specifies a pointer to a type", "Mathematical operations on pointer values"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "* dereferences a pointer, & gets the address, pointer declaration introduces a pointer, pointer arithmetic involves calculations."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('17/03/2024', '%d/%m/%Y'), #17
  name: "Pointer Concepts",
  difficulty: :HARD,
  question_overview: "Match the following expressions with their correct output assuming int x = 5 and y = 3;",
  first_group: ["x * y + 2", "++x + y", "x / ++y", "x % --y"],
  second_group: ["17", "9", "1", "2"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "17 results from multiplying x and y and adding 2. 9 is the result of incrementing x before adding y. 1 is the result of dividing x by the incremented value of y. 2 is the result of x modulo the decremented value of y."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Macros",
  difficulty: :EASY,
  question_overview: "Match the following #define macros with their correct usage.",
  first_group: ["#define PI 3.14", "#define SQUARE(x) ((x) * (x))", "#define MAX(a, b) ((a) > (b) ? (a) : (b))", "#define CHECK_ZERO(x) ((x) == 0 ? 1 : 0)"],
  second_group: ["Used to define a constant for PI", "Used to define a macro for squaring a number", "Used to define a macro to find the maximum of two numbers", "Used to define a macro to check if a number is zero"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "PI is defined as 3.14, SQUARE computes the square of x, MAX returns the maximum of a and b, CHECK_ZERO checks if x is zero."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Array Operations",
  difficulty: :MEDIUM,
  question_overview: "Match the array operations with their correct descriptions using the declarion, int arr[10] = {0};.",
  first_group: ["arr[3] = 5;", "sizeof(arr) / sizeof(arr[0])", "arr[10] = 3;"],
  second_group: ["Assigns the value 5 to the fourth element of arr", "Calculates the number of elements in arr", "Undefined behavior: writes to an out-of-bounds index"],
  correct_answers: [[0, 0], [1, 1], [2, 2]],
  correct_answer_explanation: "The fourth element of arr is set to 5. The size of arr is calculated, and writing to arr[10] is out of bounds."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "Character and String Functions",
  difficulty: :EXTREME,
  question_overview: "Match the character/string functions with their correct descriptions.",
  first_group: ["strlen(\"hello\")", "strcat(\hello\",\"world\")", "strcmp(\"hello\",\"world\")", "strncpy(dest, src, n)"],
  second_group: ["Returns the length of the string \"hello\"", "Appends \"world\" to \"hello\"", "Compares two strings \"hello\" and \"world\"", "Copies up to n characters from src to dest"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "strlen returns the length of 'hello'. strcat appends 'world' to 'hello'. strcmp compares 'hello' and 'world'. strncpy copies up to n characters."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('29/03/2024', '%d/%m/%Y'),
  name: "File Operations",
  difficulty: :EASY,
  question_overview: "Match the file operation functions with their correct descriptions.",
  first_group: ["fopen(\"data.txt\", \"r\")", "fprintf(file, \"%d\", num)", "fscanf(file, \"%d\", &num)", "fclose(file)"],
  second_group: ["Opens a file named \"data.txt\" for reading", "Writes an integer to the file", "Reads an integer from the file", "Closes the file"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "fopen opens 'data.txt' for reading. fprintf writes an integer to a file. fscanf reads an integer from a file. fclose closes the file."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('21/03/2024', '%d/%m/%Y'), #21
  name: "Bit-Wise Operations",
  difficulty: :EXTREME,
  question_overview: "Match the following bit-wise operations with their correct output assuming unsigned int x = 6, y = 12;",
  first_group: ["x & y", "x | y", "x ^ y", "~x"],
  second_group: ["4", "14", "10", "4294967290"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "These are bit-wise AND, OR, XOR, and NOT operations on the binary representations of x and y."
)

Challenge::ConnectBlocks.find_or_create_by!(
  date_when_available: Date.strptime('28/03/2024', '%d/%m/%Y'), #28
  name: "Pointer Operations",
  difficulty: :HARD,
  question_overview: "Match the following pointer operations with their correct descriptions.",
  first_group: ["int *ptr = &y;", "*ptr = y;", "int y = *ptr;", "&ptr"],
  second_group: ["ptr holds the address of y", "The value at the address ptr is set to y", "y is assigned the value at the address ptr", "The address of the pointer variable ptr"],
  correct_answers: [[0, 0], [1, 1], [2, 2], [3, 3]],
  correct_answer_explanation: "& signifies the address of something. a = b signifies setting the value of b to a. "
)
