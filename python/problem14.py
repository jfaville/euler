"""
Longest Collatz Sequence
Project Euler Problem 14

The following iterative sequence is defined for the set of positive integers:

n → n/2 (n is even)
n → 3n + 1 (n is odd)

Using the rule above and starting with 13, we generate the following sequence:

13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

Which starting number, under one million, produces the longest chain?

NOTE: Once the chain starts the terms are allowed to go above one million.

Usage:
    problem14.py <max-starting-number>
"""
from docopt import docopt
from time import clock
from math import floor
from itertools import chain

class CachedFunction(object):
    def __init__(self, function):
        self.__function = function
        self.__hashes = {}
    def __call__(self, n):
        try:
            return self.__hashes[n]
        except KeyError:
            self.__hashes[n] = self.__function(n)
            return self.__hashes[n]
    def __contains__(self, n):
        return n in self.__hashes
            
def cache(function):
    return CachedFunction(function)

def half(n):
    return n / 2

def tripleAndIncrement(n):
    return (3 * n) + 1

@cache
def next_collatz_number(n):
    if n % 2 == 0:
        return half(n)
    else:
        return tripleAndIncrement(n)

class CollatzSequence(object):
    def __init__(self, n):
        assert n >= 1 and n % 1 == 0
        self.__initial_value = n
    def __iter__(self):
        n = self.__initial_value
        evens = self.__halvingGenerator()
        odds = self.__triplingAndIncrementingGenerator()
        next(evens)
        next(odds)
        while True:
            if n % 2 == 0:
                n = evens.send(n)
                yield n
            else:
                n = odds.send(n)
                yield n
    def __halvingGenerator(self):
        n = (yield)
        while True:
            n = yield half(n)
    def __triplingAndIncrementingGenerator(self):
        n = (yield)
        while True:
            n = yield tripleAndIncrement(n)
    def __len__(self):
        for i, term in enumerate(self.__class__(self.__initial_value)):
            if term == 1:
                return i
        print("max depth at {}".format(self.__initial_value))

def longestCollatzSequenceIn(iterable):
    return max(iterable, key=lambda n: len(CollatzSequence(n)))

if __name__ == '__main__':
    args = docopt(__doc__)
    n = int(args['<max-starting-number>'])
    start = clock()
    print(longestCollatzSequenceIn(range(1, n)))
    end = clock()
    print("Time elapsed: {}s".format(end - start))