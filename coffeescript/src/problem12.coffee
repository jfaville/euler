root = exports ? window

require 'coffee-script/register';
{EulerProblem} = require '../src/common.coffee'
{pass, divides, CachedArray, generalize, product, factorsof, len} = require '../src/util.coffee'

###
Highly divisible triangular number
What is the value of the first triangle number to have over five hundred divisors?
###

len  = (x) -> x.length
distinct = (list) -> #note: optimized for lists with many duplicates
  distinctList = []
  (distinctList.push el if el not in distinctList) for el in list
  distinctList
  
count = (query, list) -> len (yes for el in list when el is query)

divisorsOf = (y) -> (x for x in [1..y] when divides x, y)
countDivisorsOf = (y) -> 
  throw new Error "#{y} must be a positive integer." unless y >= 1
  return 2 if y is 1
  factors = factorsof y
  product ((1 + count el, factors) for el in distinct factors)
  
hasOverNDivisors = (y, n) -> (len divisorsOf y) > n

triangleNumbers = new Sequence, (a) ->
  yield 0 
  yield @get(a - 1) + a

class Problem12 extends EulerProblem
  @_BruteForce: (n) ->
    x = 1
    triangleNumbers.get(x++) until hasOverNDivisors triangleNumbers.get(x), n
    triangleNumbers.get(x)
  @ByDivisorFunction: (n) -> 
    x = 1
    (x++) until (countDivisorsOf triangleNumbers.get(x)) > n
    triangleNumbers.get(x)

Problem12.solve(500)

root.Problem12 = Problem12