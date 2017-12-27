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
generalize = (func) -> (base, reducends...) -> reducends.reduce func, base
concat = generalize (a, b) -> a.concat b

###
LARGEST PALINDROME PRODUCT
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99. Find the largest palindrome made from the product of two 3-digit numbers.
###
isPalindrome = (number) ->
    string = "#{number}"
    len = string.length
    [0...Math.floor(len/2)].every (x) -> string[x] is string[len - 1 - x]
   
###
findGreatestPalindromeFromProductOfRangedIntegers = ([min, ..., max]) ->
    products = concat (y*x for y in range for x in range)...
    Math.max (products.filter isPalindrome)...
###

###
findGreatestPalindromeFromProductOfRangedIntegers = ([min, ..., max]) ->
    greatestPalindrome = 0;
    checkIfGreatestPalindrome = do->
        isGreatestPalindrome = (x) -> 
            x > greatestPalindrome and x % 11 is 0 and isPalindrome x
        (x) -> if isGreatestPalindrome x then greatestPalindrome = x else false
    checkIfGreatestPalindrome y*x for y in [x..min] for x in [max..min]
    greatestPalindrome
###

class Palindrome
    @check: (x) ->
        return false if x instanceof Number and x % 1 is 0 and x % 11 isnt 0
        str = "#{x}"; len = str.length; med = Math.floor len/2
        [0...med].every (n) -> str[n] is str[len - 1 - n]
    constructor: (x) -> @set x
    get: -> @_value
    set: (x) -> 
        throw new Error "#{x} must be a palindrome." unless Palindrome.check x
        @_value = x

class Maximum
    constructor: (@_class = Number, @_value = 0) -> 
    get: -> @_value
    set: (n) ->
        unless n >= @_value
            throw new RangeError "#{n} must be at least #{@_value}."
        unless @_class.check? n or n instanceof @_class
            throw new TypeError "#{n} must be a #{@_class.name}."
        @_value = n
    
class Problem4 extends EulerProblem
    @solution: ([min, ..., max] = [100..999]) ->
        greatestPalindrome = new Maximum Palindrome
        (try greatestPalindrome.set y*x) for y in [x..min] for x in [max..min]
        greatestPalindrome.get()

root.Palindrome = Palindrome
root.Maximum = Maximum
root.Problem4 = Problem4