root = exports ? window

require 'coffee-script/register';
{EulerProblem} = require '../src/common.coffee'

###
Utility Methods
###
generalize = (func) -> (base, reducends...) -> 
    if not reducends? then [base, reducends...] = base
    reducends.reduce func, base
sum = generalize (a, b) -> a + b
square = (a) -> a*a

###
SUM SQUARE DIFFERENCE
The sum of the squares of the first ten natural numbers is, 

12 + 22 + ... + 102 = 385

The square of the sum of the first ten natural numbers is, 

(1 + 2 + ... + 10)2 = 552 = 3025

Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640. Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
###

class Problem6 extends EulerProblem
  @BruteForce: (range = [1..100]) -> 
      (square sum range...) - sum (range.map square)...
  @Arithmetic: ([min, ..., n] = [1..100]) -> 
      (3*n**4 + 2*n**3 - 3*n**2 - 2*n)/12
      
root.Problem6 = Problem6