from EulerProblem import EulerProblem
from operator import mul
from decimal import Decimal

'''
SPECIAL PYTHAGOREAN TRIPLET

A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

a2 + b2 = c2
For example, 32 + 42 = 9 + 16 = 25 = 52.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.
'''

def product(iterable): 
    if len(iterable) == 0: 
        return 0
    else:
        return reduce(mul, iterable)

def findIntegralSidesOfRightTriangleWithPerimeter(p): 
    a = b = Decimal(1)
    while a < p - 1: 
        b = Decimal(1)
        while b < p - a:
            c = (a*a + b*b).sqrt()
            if a + b + c > p: 
                break
            if c == int(c) and a + b + c == p: 
                return (int(a), int(b), int(c))
            b += 1
        a += 1
    return None
    
def getInput():
    return {
        "p": int(raw_input("Provide the sum of the Pythagorean triplet whose "
                           "product is to be found: "))
    }


def bruteForce(p = 1000): 
    return product(findIntegralSidesOfRightTriangleWithPerimeter(p))

problem9 = EulerProblem(getInput, bruteForce)
problem9.solve()