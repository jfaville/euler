root = exports ? window

require 'coffee-script/register';
{EulerProblem} = require '../src/common.coffee'
{SieveOfEratosthenes, sum} = require '../src/util.coffee'

###
SUMMATION OF PRIMES
The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
Find the sum of all the primes below two million.
###

  
class Problem10 extends EulerProblem
  @BySieveOfEratosthenes: (max = 2000000) -> 
    sum(SieveOfEratosthenes.findAllPrimesBelow max)
  @ByOldSieveOfEratosthenes: (max = 2000000) -> 
    sum(SieveOfEratosthenes.findAllPrimesBelowOld max)
    
class SieveOfEratosthenesTest extends EulerProblem
  @BySieveOfEratosthenes: (max = 10) -> 
    SieveOfEratosthenes.findAllPrimesBelow max
  @ByOldSieveOfEratosthenes: (max = 10) -> 
    SieveOfEratosthenes.findAllPrimesBelowOld max

Problem10.solve(2000000)

root.Problem10 = Problem10