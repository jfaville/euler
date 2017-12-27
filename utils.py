import types
from math import factorial
from itertools import combinations, repeat

class CachedFunction(object):
    def __init__(self, function):
        self.__function = function
        self.__hashes = {}
    def __call__(self, *args):
        if args not in self:
            self.__hashes[args] = self.__function(*args)
        return self.__hashes[args]
    def __contains__(self, key):
        return key in self.__hashes
    def __get__(self, instance, cls=None):
        return types.MethodType(self, instance)
      
def cache(function):
    return CachedFunction(function)

def cacheif(predicate):
    # TODO get working
    def conditionally_cache_function(function):
        cached_function = CachedFunction(function)
        def conditionally_cached_function(*args):
            if predicate(*args):
                cached_function(*args)
            else:
                function(*args)
        return conditionally_cached_function
    return conditionally_cache_function
      
def isPowerOf2(n):
    return (n > 0) and not (n & (n - 1))
  
class combinationsof(object):
    def __init__(self, iterable, k):
        self.__iterable = iterable
        self.__items = int(k)
    @cache
    def __len__(self):
        n = len(self.__iterable)
        k = self.__items
        return int(factorial(n) / (factorial(k) * factorial(n - k)))
    def __iter__(self):
        yield from combinations(self.__iterable, self.__items)
        
def accumulate(generator):
    def accumulator(*args, **kwargs):
        return sum(generator(*args, **kwargs))
    return accumulator
        
class nitems():
    def __init__(self, n):
        self.__n = int(n)
    def __iter__(self):
        yield from repeat(None, self.__n)
    def __len__(self):
        return self.__n