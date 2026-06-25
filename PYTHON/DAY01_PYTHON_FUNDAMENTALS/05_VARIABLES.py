# ====================================================================================
# Day 05 – PYTHON : PYTHON VARIABLES
# ====================================================================================

'''
VARIABLE:
  - Variable Refer to a memory location. that we used to store data.
  - When we decalre variable its allocat a space in memory along with datatype.
  - Each variable have its unique name and unique address.   
'''

'''
Note:
if :
  x = 10
  y = 10

python is sophisticated language. if the two or more variable have same value
python does not create another uncessesary space in memory. both the x,y variable point to the same value. 
this feature save the memory.
'''

# x is varible name and 10 is value assigned to the var
x = 10
print(x) # print the content of x var
print(bin(id(x))) # print address of x var in binary form

# RULES TO INITIALIZE AND DECALRE VAR
a = 10
A = 20
a_ = 1
_a_B101 = "string"

# invalid
'''
10 = 10
22var = 23
-as = 30
etc.
'''

# -----------------------------------------
name = "Mazhar kakar"
print("Your name is: ",name)

name = "Mazhar Raza"
print("Your name is changed: ",name)

# name was contain "Mazhar kakar"
# now again we changed the value by "Mazhar Raza"
# ----------------------------------------

