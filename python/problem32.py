"""
Pandigital products
Problem 32 

We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

Usage:
    problem32.py <n>
"""
from docopt import docopt
from time import clock
from utils import cache, cacheif
from itertools import permutations
    
def int_from_digits(digits):
    return int("".join(str(d) for d in digits))

def digits_of(integer):
    return [int(d) for d in str(integer)]

def var_length_permutations(iterable, lengths):
    for l in lengths:
        yield from permutations(iterable, l)

def pandigital_products(n=9):
    products = set()
    for multiplier in var_length_permutations(range(1, n+1), range(1, (n+1) // 2)):
        digits = set(range(1, n+1)) - set(multiplier)
        for multiplicand in var_length_permutations(digits, range(1, len(digits) // 2)):
            product = int_from_digits(multiplier) * int_from_digits(multiplicand)
            product_digits = set(digits) - set(multiplicand)
            if sorted(digits_of(product)) == sorted(list(product_digits)):
                products.add(product)
    return products
  
def pandigital_products_old(n=9):
    products = set()
    for digits in permutations(range(1,n+1), n):
        for sep1 in range(1, n//2):
            sep2 = sep1 + 1
            while n - sep2 > sep2 - 2:
                product = (int_from_digits(digits[:sep1]) * 
                           int_from_digits(digits[sep1:sep2]))
                if product == int_from_digits(digits[sep2:]):
                    products.add(product)
                sep2 += 1
    return products

if __name__ == '__main__':
    args = docopt(__doc__)
    n = int(args['<n>'])
    start = clock()
    print(sum(pandigital_products(n)))
    #print(pandigital_products(n))
    end = clock()
    print("Time elapsed: {}s".format(end - start))