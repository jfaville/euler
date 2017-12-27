###
Utility Methods
###
assert = require('assert')
generalize = (func) -> (base, reducends...) -> reducends.reduce func, base
concat = generalize (a, b) -> a.concat b
sum = generalize (a, b) -> a + b
union = generalize (a, b) -> concat a, (el for el in b when el not in a)

###
LARGEST PRIME FACTOR
The prime factors of 13195 are 5, 7, 13 and 29.
What is the largest prime factor of the number 600851475143 ?
###

flatten = (array) ->
    if el instanceof Array then concat (flatten el for el in array)... else el
    
lastDigit = (number) -> parseInt "#{number}".slice(-1), 10

divides = (divisor, dividend) -> switch divisor
    when 2 then lastDigit(dividend) % 2 is 0
    when 3 then (sum (x for x in "#{dividend}")...) % 3 is 0
    when 5 then lastDigit(dividend) is (0 or 5)
    else dividend % divisor is 0
    

factor = (number) -> switch
    when (number is 0) or (number is 1) then []
    when divides 2, number then concat [2], factor number/2
    else 
        x = 3
        x += 2 until divides x, number
        concat [x], factor number/x
        
largestPrimeFactor = (number) -> Math.max (factor number)...

console.log largestPrimeFactor 600851475143