from math import sqrt
var = ""

def read_var(prompt):
    while True:
        var = input(prompt)
        try:
            var = float(var)
            return var
        except:
            print("Invalid input, please try again.")

def stringify(num):
    if num > 0:
        num = "+" + str(num)
        return num
        
    elif num < 0:
        num = str(num)
        return num
            
a = read_var("Enter coefficient of squared term: ")
b = read_var("Enter coefficient of linear term: ")
c = read_var("Enter constant term: ")

if a == 0:
    if b == 0:
        print("Invalid equation!")
    else:
        result = -c/b
        print(result)
else:
    delta = b**2-4*a*c
    if delta > 0:
        result1 = (-b+sqrt(delta))/(2*a)
        result2 = (-b-sqrt(delta))/(2*a)
        print("Solution 1: ",result1)
        print("Solution 2: ",result2)
    elif delta == 0:
        result = -b/(2*a)
        print("Solution: ",result)
    else:
        real = str(-b/(2*a))
        result1 = (sqrt(-delta))/(2*a)
        result2 = (-sqrt(-delta))/(2*a)
        imag1 = stringify(result1)+"i"
        imag2 = stringify(result2)+"i"
        result1 = real + imag1
        result2 = real + imag2
        print("Solution 1: ",result1)
        print("Solution 2: ",result2)