"""
Convergents of e
Problem 65

The square root of 2 can be written as an infinite continued fraction.
The infinite continued fraction can be written, √2 = [1;(2)], (2) indicates 
that 2 repeats ad infinitum. In a similar way, √23 = [4;(1,3,1,8)].

It turns out that the sequence of partial values of continued fractions for 
square roots provide the best rational approximations. Let us consider the 
convergents for √2.

Hence the sequence of the first ten convergents for √2 are:

1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985, 3363/2378, ...
What is most surprising is that the important mathematical constant,
e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].

The first ten terms in the sequence of convergents for e are:

2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...
The sum of digits in the numerator of the 10th convergent is 1+4+5+7=17.

Find the sum of digits in the numerator of the 100th convergent of the 
continued fraction for e.

Usage:
    problem65.py <convergent>
"""
from docopt import docopt
from time import clock
from itertools import islice
from fractions import Fraction

class ContinuedFraction(Fraction):
    def __new__(cls, rep):
        if len(rep) == 0:
            return Fraction()
        elif len(rep) == 1:
            return Fraction(rep[0])
        return rep[0] + Fraction(1, cls(rep[1:]))
class InfiniteContinuedFraction(object):
    def __init__(self, seq):
        self._seq = seq
    def convergent(self, n):
        return ContinuedFraction(list(islice(self._seq, n)))
    
def cf_representation_of_e():
    yield 2
    n = 2
    while True:
        yield 1
        yield n
        n = n + 2
        yield 1

if __name__ == '__main__':
    args = docopt(__doc__)
    k = int(args['<convergent>'])
    start = clock()
    convergent = InfiniteContinuedFraction(cf_representation_of_e()).convergent(k)
    print(sum(int(d) for d in str(convergent.numerator)))
    end = clock()
    print("Time elapsed: {}s".format(end - start))