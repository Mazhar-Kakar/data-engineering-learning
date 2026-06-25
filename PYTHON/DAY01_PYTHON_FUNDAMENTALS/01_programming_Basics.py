# ====================================================================================
# Day 01 – PYTHON : PROGRAMMING BASICS
# ====================================================================================

# ------------------------------------------------------------------------------------
# BASIC TERMINOLOGIES
# ------------------------------------------------------------------------------------
"""
WHAT IS PROGRAMMING
Programming is a way to communicate with a computer and tell it what tasks to perform
in order to solve a problem.

PROGRAM
A program is a set of instructions given to a computer to solve a particular problem.

Example:
    sum = a + b

ALGORITHM
An algorithm is a sequence of steps used to solve a problem.
"""

# ------------------------------------------------------------------------------------
# PROGRAMMING LANGUAGE
# ------------------------------------------------------------------------------------
"""
A programming language is a formal language used to write programs that computers
can understand and execute.

LEVELS OF LANGUAGES

1. Natural Language
   - Languages humans use for communication
   - Examples: English, Hindi

2. High-Level Language
   - Easy for humans to read and write
   - More abstract and user-friendly
   - Examples: Python, Java

3. Low-Level Language
   - Closer to machine language
   - Harder for humans to read
   - Examples: Assembly, C

4. Machine Language
   - The lowest-level language
   - Directly understood by the computer
   - Written in binary (0s and 1s)
   Example:
       010101010101
"""

# ------------------------------------------------------------------------------------
# COMPUTER ARCHITECTURE
# ------------------------------------------------------------------------------------
"""
SECONDARY MEMORY --> MAIN MEMORY (RAM) --> CACHE (L1,L2,L3) --> CPU --> OUTPUT

1. The program is stored in secondary storage
   Example: day01_programming_basics.py

2. When we run the program, the Python interpreter starts reading the code.

3. The interpreter converts the high-level code into machine-understandable
   instructions (bytecode).

4. The data and instructions are loaded into RAM.

5. The CPU fetches and executes the instructions.

6. The program produces output.

SUMMARY FLOW:
Program File → Interpreter → RAM → CPU → Output
"""

# ------------------------------------------------------------------------------------
# COMPILER VS INTERPRETER
# ------------------------------------------------------------------------------------
"""
COMPILER:

A compiler converts the entire program into machine code before execution.

Characteristics:
- Compilation happens once
- Produces an object/executable file
- Execution is usually faster

Examples:
- C
- C++
- Java (partially compiled)

INTERPRETER:

An interpreter converts and executes code line by line during runtime.

Characteristics:
- No separate executable file
- Translation and execution happen together
- Usually slower than compiled languages

Examples:
- Python
- Ruby
- JavaScript
- PHP
"""

# ------------------------------------------------------------------------------------
# WHAT IS PYTHON
# ------------------------------------------------------------------------------------
"""
Python is a high-level, interpreted, dynamically typed, platform-independent,
object-oriented programming language.

Key Features:

High-Level
- Easy to read and write
- Syntax is close to English

Interpreted
- Code is executed line by line

Dynamically Typed
- No need to declare variable data types explicitly

Platform Independent
- Runs on Windows, Linux, Mac, etc.

Object-Oriented
- Supports classes and objects

Large Ecosystem
- Huge libraries and strong community support

Python is widely used in:
- Automation
- Data Engineering
- Data Science
- Machine Learning
- Artificial Intelligence
"""

# ------------------------------------------------------------------------------------
# HOW PYTHON WORKS INTERNALLY
# ------------------------------------------------------------------------------------
"""
When a Python program runs:

1. Python source code (.py file) is given to the interpreter.
2. The interpreter compiles the code into bytecode.
3. The Python Virtual Machine (PVM) reads the bytecode.
4. The PVM executes the instructions using the system CPU.

Execution Flow:
  - Python File (.py)--> Python Interpreter--> Bytecode-->Python Virtual Machine (PVM)--> CPU--> Output
"""