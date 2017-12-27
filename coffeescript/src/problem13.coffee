root = exports ? window

require 'coffee-script/register';
{EulerProblem} = require '../src/common.coffee'
{} = require '../src/util.coffee'

###
Highly divisible triangular number
What is the value of the first triangle number to have over five hundred divisors?
###

class Problem13 extends EulerProblem
  @SumIntegersByColumns: (integers...) -> 
    reversedDigitsOfSum = []
    n = 1 #power of ten which describes the current place
    while
      sumOfNthDigits = sum (digitsof int)[-n] for int in integers
      carryOver = Math.floor sumOfNthDigits / 10
      digit = sumOfNthDigits % 10
      reversedDigitsOfSum[n-1] = 
    sum += n[-i]

Problem12.solve(5)

root.Problem12 = Problem12