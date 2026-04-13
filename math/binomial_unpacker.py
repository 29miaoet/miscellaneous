from math import factorial


def choose_co(n,k):
    result = str((factorial(n))//(factorial(k)*factorial(n-k)))
    return result
    
def convert_to_exponent(number):
    order = ""
    number = str(number)
    for char in number:
        char  = int(char)
        order += (superscripts[char])
    
    return order


def write_expansion():
    equation = ""

    equation += "x"
    equation += convert_to_exponent(power)

    equation += "+"


    equation += str(power)
    equation += "x"
    equation += convert_to_exponent(power-1)
    equation += "y"
    equation += "+"

    for i in range(2,power-1):
        equation += choose_co(power,i)
        equation += "x"
        equation += convert_to_exponent(power-i)
        equation += "y"
        equation += convert_to_exponent(i)
        equation += "+"


    equation += str(power)
    equation += "x"
    equation += "y"
    equation += convert_to_exponent(power-1)

    equation += "+"


    equation += "y"
    equation += convert_to_exponent(power)
    print(equation)
    
    
superscripts = ['⁰','¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹']

power = input("Enter power: ")
while not power.isdigit():
    power = input("Invalid input, please try again: ")

power = int(power)

print()
if power == 0:
    print("1")
elif power == 1:
    print("x+y")
elif power == 2:
    print("x²+2xy+y²")
else:
    write_expansion()
print()


