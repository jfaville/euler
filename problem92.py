"""
Square Digit Chains
Project Euler Problem 92

A number chain is created by continuously adding the square of the digits in a number to form a new number until it has been seen before.

For example,

44 → 32 → 13 → 10 → 1 → 1
85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89

Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop. What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.

How many starting numbers below ten million will arrive at 89?

Usage:
    problem92.py <max>
"""
from docopt import docopt
from time import clock
from utils import cache, cacheif
from itertools import takewhile, chain, islice, combinations_with_replacement, permutations, repeat

def takeuntil(pred, seq):
    takewhile(lambda x: not pred, seq)
    
def negate(predicate):
    def negation(*args, **kwargs):
        return not predicate(*args, **kwargs)
    
class Sequence():
    def __init__(self):
        raise NotYetImplementError
    @cache
    def get(self, n, default=None):
        for i, term in enumerate(self):
            if i == n:
                return term
        return default
    @cache
    def terms(self):
        terms = []
        for term in self:
            terms.append(term)
            if terms.count(term) > 1:
                break
        return terms
    def __contains__(self, key):
        return key in self.terms()
    def __getitem__(self, key):
        if isinstance(key, slice):
            return islice(slice.start, slice.stop, slice.step)
        elif self.get(key) is not None:
            return self.get(key)
        else:
            raise KeyError()
    def __iter__(self):
        raise NotYetImplementError
    def __str__(self):
        return ", ".join(str(term) for term in self.terms()) + "..."

class squareDigitChain(Sequence):
    def __init__(self, starting_digit):
        self.__starting_digit = starting_digit
    def __iter__(self):
        n = self.__starting_digit
        while True:
            yield n
            n = sum(int(x) * int(x) for x in str(n))
            
@cache
def ishappy(n):
    # return 1 in squareDigitChain(n)
    n = integerFromDigits(sorted(d for d in str(n) if d != 0))
    if not n:
        return False
    elif n is 1:
        return True
    elif n is 4:
        return False
    else:
        return ishappy(sum(int(d) * int(d) for d in str(n)))
    
def integerFromDigits(digits):
    return int("".join(str(d) for d in digits))

def accumulate(generator):
    def accumulator(*args, **kwargs):
        return sum(generator(*args, **kwargs))
    return accumulator

@accumulate
def happyNumbersLength(max=None):
    if max is None:
        return float("inf")
    if max % 10 == 0:
        for digits in combinations_with_replacement(range(10), len(str(max))-1):
            if ishappy(integerFromDigits(digits)):
                # yield len(set(p for p in permutations(digits) if integerFromDigits(p) < max))
                yield len(set(permutations(digits)))
    else:
        for digits in combinations_with_replacement(range(10), len(str(max))-1):
            if ishappy(integerFromDigits(digits)):
               yield len(set(p for p in permutations(digits) if integerFromDigits(p) < max))
      
            
def unhappyNumbersLength(max=None):
    if max is None:
        return float("inf")
    return (max - 1) - happyNumbersLength(max=max)
  
if __name__ == '__main__':
    args = docopt(__doc__)
    k = int(args['<max>'])
    start = clock()
    print(unhappyNumbersLength(k))
    #print(sum(1 for n in range(1, k) if not ishappy(n)))
    end = clock()
    print("Time elapsed: {}s".format(end - start))