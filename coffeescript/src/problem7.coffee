root = exports ? window

require 'coffee-script/register';
{EulerProblem} = require '../src/common.coffee'
{SieveOfEratosthenes} = require '../src/util.coffee'

###
10001ST PRIME
By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13. What is the 10 001st prime number?
###

#Aliases
ln = Math.log

findUpperBoundOnNthPrime = (n, stepSize = 1) ->
  underestimatedPrimeCountingFunction = (y) -> switch
    when y >= 599 then (y / ln y) * (1 + 1 / ln y) #Dussart 1998
    when y >= 55 then y / ((ln y) + 2) #Rosser 1941
    else 0
  x = 1
  x += stepSize until underestimatedPrimeCountingFunction(x) > n
  x
  
class Problem7 extends EulerProblem
  @SieveMethod: (n = 10001) -> 
    max = findUpperBoundOnNthPrime(n)
    (SieveOfEratosthenes.findAllPrimesBelow max)[n-1]

root.Problem7 = Problem7
root.findUpperBoundOnNthPrime = findUpperBoundOnNthPrime