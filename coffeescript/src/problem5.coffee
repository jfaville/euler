root = exports ? window

require 'coffee-script/register';
{EulerProblem} = require '../src/common.coffee'

###
Aliases
###
len = (a) -> a.length or throw new TypeError "Parameter is of unknown length."

###
Utility Methods
###
generalize = (func) -> (base, reducends...) -> 
    if not reducends? then [base, reducends...] = base
    reducends.reduce func, base
concat = generalize (a, b) -> a.concat b
sum = generalize (a, b) -> a + b
greatest = generalize (a, b) -> Math.max a, b

digitsOf = (number) -> (parseInt x for x in "#{number}")
lastDigitOf = (number) -> [..., last] = digitsOf number; last

divides = (divisor, dividend) -> switch divisor
  when 1 then yes
  when 2 then (lastDigitOf dividend) % 2 is 0
  when 3 then (sum digitsOf dividend) % 3 is 0
  when 5 then (lastDigitOf dividend) is 0 or (lastDigitOf dividend) is 5
  else dividend % divisor is 0

###
SMALLEST MULTIPLE
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder. What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
###

###
findAllPrimesInRange = ([min, ..., max] = [1, 100]) ->
  throw new Error "#{arguments[0]} is not an ascending range." unless min <= max
  i = 0; primes = (x for x in [3..max] by 2)
  while factor = primes[i++]
    primes = (x for x in primes when not divides factor, x or x is factor)
  (x for x in (concat [1, 2], primes) when min <= x <= max)
  
LCMThroughPrimeFactors = (divisors) ->
  findLCMOfPrimeFactors = (divisors) ->
    primes = findAllPrimesInRange(divisors)
    x = greatestPrime = Math.max primes...
    x += greatestPrime until (primes.every (prime) -> divides prime, x)
    x
  x = LCMOfPrimeFactors = findLCMOfPrimeFactors(divisors)
  x += LCMOfPrimeFactors until (divisors.every (y) -> divides y, x)
  x
###

LCM = (divisors) ->
  divisorIsRedundant = (x) -> divisors.some (y) -> y > x and divides x, y
  divisors = (x for x in divisors when not divisorIsRedundant x)
  lcm = greatestDivisor = Math.max divisors...
  lcm += greatestDivisor until (divisors.every (y) -> divides y, lcm)
  lcm
  
class Problem5 extends EulerProblem
  @solution: (divisors = [1..20]) -> LCM divisors
  
root.LCM = LCM
root.Problem5 = Problem5