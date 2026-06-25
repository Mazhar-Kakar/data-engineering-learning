# ====================================================================================
# Day 06 – PYTHON : PYTHON DATA TYPES
# ====================================================================================

'''
DATATYPE:
  Data Type ensures which type of data will store in memory location.
  - ex- integer, string, floating point numbers, boolean etc.
'''

# NOTE:
# In python we dont need to explicitly mentioned data type its Automatically detect datatype by value.
x = 12 # 12 is integer number, python dinamically detect data type. (int)

# -----------------------------------------------------------------------------------------
# python built in DataType:
a = 12 # integer - int
b = 12.5 # flot - float
c = "string" # string, sequence of character, - str
d = True # boolean, True and False
e = None # None, absence of data

# Type() Function tells datatype of the variables
print("a = 12: ",type(a)) 
print("b = 12.5: ",type(b)) 
print("c = \"string\": ",type(c)) 
print("d = True: ",type(d)) 
print("e = None: ",type(e)) 

# O/P
'''
a = 12:  <class 'int'>
b = 12.5:  <class 'float'>
c = "string":  <class 'str'>
d = True:  <class 'bool'>
e = None:  <class 'NoneType'>
'''
# -----------------------------------------------------------------------------------------

# IMPLICIT TYPE CASTING:
  # TYPE CASTING MEANS: CHANGING THE DATATYPE OF VARIABLE DYNMICALLY, INTERNALLY
print("\n=================================================================================================")
x = 12
y = 12.5
z = y + x # z contain floating poin number, implicit type casting
print("Result will be in float: ",z)

'''
Rules:
 - int + float = float, order does not matter
''' 

# EXPLICIT TYPE CASTING:
  # WE EXPLICITLY CHANGE THE DATATYPE OF VARIABLE

# RULES:
  # STR CAN NOT CONVERT INTEGER
  # INTEGER CAN CONVERT INTO STR 

x = 13
y = float(x)
print(y)

x = 13
y = str(x) # int to str

a = "string"
# b = int(a) : str to int invalid

a = True
b = str(a) # b contain "True" as string
print(b)

a = None
b = str(a) # b contain "None" as string
print(b)

# ------------------------------------------------------------------------------------------

'''
METHODS AND FUNCTIONS:
  FUNCTION IS BLOCK OF REUSABLE CODE. THAT TAKES A INPUT AND USE FUNCTION LOGIC AND RETURN OUTPUT

IN PYTHON WE HAVE DIFFERENT TYPS OF FUNCTIONS:
  - EXTERNAL LIBRARY FUNCTIONS
  - USER_DEFINE FUNCTIONS

  - BUILT-IN FUCTIONS
      - STANDALONE FUNCTIONS
        EX- PRINT(), TYPE()

      - METHODS OF CLASS:
        THAT USED TO MANIPULATE VARIABLES
        EX- UPPER(), REPLACE()

      - OPERATORS: + / > < == IN OR
'''

'''
PYTHON STANDARD LIBRARY ---> BUILT-IN MODULES ---> 
  - #01 MODULE CONTAINS STANDALONE FUNCTIONS, 
    - METHODS OF CLASS, CLASS FOR EACH DATATYPE WHERE CONTAIN RELATED FUNCTION EX- UPPER(), LOWER()
  - #02 MATH MODULE
    - CONTAIN MATHS REALTED FUNCTIONS
ETC.
'''

# FUNCTIONS:
print(type(a))

# METHODS:
  # FUNCTION BELONGS TO OBJECT/CLASS
a = "hello".upper()


