"""
Circular primes
Problem 35 
The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.

There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

How many circular primes are there below one million?

Usage:
    problem32.py <max>
"""
from docopt import docopt
from time import clock
from utils import accumulate
from itertools import permutations, combinations_with_replacement
from math import sqrt, floor
from operator import itemgetter
    
class RangedFunction(object):
    def __init__(self, function, *positions):
        self.__function = function
        self.__positions = positions
    def __call__(self, *args):
        if not self.__positions:
            for arg in args[self.__positions[0]]:
                partial_args = (None,) * self.__positions[0] + (arg,)
                partial = PartialFunction(self.__function, (self.__positions[0]))
                yield from RangedFunction(partial, self.__positions[1:])
        else:
            return self.__function(*args)
                
class PartialFunction(object):
    def __init__(self, function, *args):
        self.__function = function
        self.__args = args
    def __call__(self, *args, **kwargs): # TODO Add kwargs functionality
        enumerated = ((i, x) for (i, x) in enumerate(self.__args) if x is not None)
        new_args = list_multiple_insert(list(args), enumerated)
        print(new_args)
        self.__function(*new_args)
        
def list_multiple_insert(uninserted, tuples):
    for i, (j, item) in enumerate(sorted(tuples, key=itemgetter(0))):
        uninserted.insert(item, i + j)
    return uninserted

def update_list(original, updates):
    modified = list()
    for i, update in enumerate(updates):
        if update is not None: modified[i] = update
    return modified

def ranged(*args):
    return PartialFunction(RangedFunction, None, *args)
    
ranged_combinations_with_replacement = ranged(1)(combinations_with_replacement)

def int_from_digits(digits):
    return int("".join(str(d) for d in digits))

class PrimeSieve(object):
    def __init__(self, max=1000000):
        self._arr = [False, False] + [True for _ in range(max)]
        for is_prime, p in enumerate(self._arr[2:floor(sqrt(max))]):
            if not is_prime:
                continue
            for n in range(p + 1, max, p):
                self._arr[n] = False
    def __next__(self):
        yield from (p for is_prime, p in enumerate(self._arr) if is_prime)
    def isprime(self, n):
        return self._arr[n]
    
@accumulate
def circular_primes_len(maximum=None):
    if maximum is None:
        return float("inf")
    elif not str(maximum).isdigit():
        raise ValueError("Maximum value must be integral")
    sieve = PrimeSieve(maximum)
    print(len(str(maximum)))
    for digits in ranged_combinations_with_replacement(range(10), 
                                                       range(1, len(str(maximum)))):
        if int_from_digits(digits) in [2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, 97]:
            print(int_from_digits(digits))
        if all(sieve.isprime(int_from_digits(p)) for p in permutations(digits)):
            print("identified")
            yield len(set(permutations(digits)))
            # yield len(set(p for p in permutations(digits) if int_from_digits(p) < max))

if __name__ == '__main__':
    args = docopt(__doc__)
    n = int(args['<max>'])
    start = clock()
    print(circular_primes_len(n))
    end = clock()
    print("Time elapsed: {}s".format(end - start))