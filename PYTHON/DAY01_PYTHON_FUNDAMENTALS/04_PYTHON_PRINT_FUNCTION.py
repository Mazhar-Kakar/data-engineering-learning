
# ====================================================================================
# Day 04 – PYTHON : PYTHON PRINT() FUNCTION
# ====================================================================================


# print() function in python used to display message or variable on a screen
print("Hello World!")

print("Hello\nWorld!") # \n new line
print("Hello\tWorld!") # \t tab

# Along with alphabets and numbers we have special character for specific job
# to escap these character we use \ back slash 
print("Hello World!\"") # \" this is called escape sequences
print('Hello World!\'')

print('Hello World!\\n')
print('Hello World!\\')

print('''This is python print()
whatever i will type inside triple qoutes it will print in new line as per the formate ''')

a = 12 - 6
print("12 - 6 = ",a)

print(f"12 - 6 = {a}") # f string formatting

print("Another way of string formatting {} {}".format(a,a))