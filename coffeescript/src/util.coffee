root = exports ? window

###
generalize() takes a binary operation and returns a corresponding iterated binary operation.
###

generalize = (func) -> (base, reducends...) -> 
    if reducends.length is 0 then [base, reducends...] = base
    reducends.reduce func, base
root.generalize = generalize
    
    
pass = () ->
root.pass = pass

identity = (x) -> x
root.identity = identity
  
###
sum() is the iterated binary operation of addition.
###

sum = generalize (a, b = 0) -> a + b
root.sum = sum

product = generalize (a, b = 1) -> a * b
root.product = product

###
union() is the iterated binary operation of the binary union, which for two arrays a, b returns the array of all x such that x ∈ a or x ∈ b.
###

union = generalize (a, b) -> a.concat (el for el in b when el not in a)
root.union = union

concat = generalize (a, b) -> a.concat b
root.concat = concat

intersect = generalize (a, b) -> x for x in a when x in b
root.intersect = intersect

relativeComplement = (a, b) -> x for x in a when x not in b
root.relativeComplement = relativeComplement

disjoint = generalize (a, b) -> relativeComplement (union a, b), (interect a, b)
root.disjoint = disjoint

len = (x) -> x.length
root.len = len

numericalSort = (array) -> Array::sort.call(array, (a, b) -> a - b)
root.numericalSort = numericalSort

setsAreEqual = generalize (a, b) -> (disjoint a, b).length is 0
root.setsAreEqual = setsAreEqual

cache = (func) -> (a, @_array = []) -> @_array[a] ?= func a
root.cache = cache

digitsOf = cache (number) -> (parseInt x for x in "#{number}")
root.digitsOf = digitsOf
root.digitsof = digitsOf

lastDigitOf = cache (number) -> [..., last] = digitsOf number; last
root.lastDigitOf = lastDigitOf

divides = (divisor, dividend) -> switch divisor
  when 1 then yes
  when 2 then (lastDigitOf dividend) % 2 is 0
  when 3 then (sum digitsOf dividend) % 3 is 0
  when 5 then (lastDigitOf dividend) is 0 or (lastDigitOf dividend) is 5
  else dividend % divisor is 0
root.divides = divides

isNumber = (number) -> not isNaN(number)
root.isNumber = isNumber

factorsOf = cache (number) -> switch
  when (number is 0) or (number is 1) then []
  when divides 2, number then concat [2], factorsOf number/2
  else 
    x = 3
    x += 2 until divides x, number
    concat [x], factorsOf number/x
root.factorsOf = factorsOf
root.factorsof = factorsOf

class SieveOfEratosthenes
  @findAllPrimesInRange: ([min, ..., max]) ->
    throw new Error "#{arguments[0]} is not an ascending range." unless min <= max
    (x for x in @findAllPrimesBelow max when x >= min)
  @findAllPrimesBelow: (max) ->
    encode =  (n) -> (n - 1) / 2
    decode =  (n) -> 2*n + 1
    
    primalities = (yes for x in [0..encode max])
    primalities[encode 1] = no
    
    for primality, index in primalities when index < encode Math.sqrt max
      continue unless primality is yes
      x = decode index
      y = x**2
      until y > max
        primalities[encode y] = no
        y += x
        
    concat [2], 
      (decode index for primality, index in primalities when primality is yes)
  @findAllPrimesBelowOld: (max) ->
    primalities = (yes for x in [0..max])
    primalities[0] = primalities[1] = no
    for primality, x in primalities when x < Math.sqrt max
      continue unless primality is yes
      y = x**2
      until y > max
        primalities[y] = no
        y += x
    (x for primality, x in primalities when primality is yes)
    
root.SieveOfEratosthenes = SieveOfEratosthenes

class CachedArray
  constructor: (@_array = [], @calculate = -> 0) ->
  get: (a) -> @_array[a] ?= @calculate a
  set: (a, b) -> @_array[a] = b
  
class SubclassedArray
  @_array = []
  for method in Object.getOwnPropertyNames(Array::)
    @::[method] = -> @_array[method](arguments...)
  Object.defineProperties @prototype,
    length: 
      get: -> @_array.length
      set: (value) -> @_array.length = value
      
class SubclassedArray extends Array
  for method in Object.getOwnPropertyNames(Array::)
    @::[method] = -> @_array[method](arguments...)
  Object.defineProperties @prototype,
    length: 
      get: -> @_array.length
      set: (value) -> @_array.length = value
  toString: -> @_array.toString()
  constructor: (@_array...) ->
    callable = (args...) ->
       @[@callable](args...) if args else @
    for property of @
      callable[property] = @[property]
    return callable
  
  
class Sequence
  @MAX_FINITE_SEQUENCE_LENGTH = 5000
  constructor: (@_generator = -> undefined) ->
  get: (a) -> 
    if @length and a >= @length then throw "The given index exceeds the maximum index of the sequence."
    else @_terms[a] ?= @_generator.next(seq) until @_terms.length is a
  set: (a, b) -> throw "You cannot set specific terms of a sequence."
  isFinite: (sequence = @) -> Number.isFinite(sequence.length) is true
  isInfinite: (sequence = @) -> Number.isFinite(sequence.length) is false
  isIncreasing: (sequence = @) -> 
  Object.defineProperties @prototype,
    length: 
      get: -> @_length ?= do ->
        x = @_terms.length - 1
        pass until (@get x++)? is no or x > @MAX_FINITE_SEQUENCE_LENGTH
        x if x <= MAX_FINITE_SEQUENCE_LENGTH else Number.POSITIVE_INFINITY
      set: (length) ->
        assert isNumber(length)
        @length = length
    
  
  
class IndexObfuscatedArray
  constructor: (@_array = [], @_encode = identity) ->
  get: (a) -> @_array[@_encode a]
  set: (a, b) -> @_array[@_encode a] = b

root.CachedArray = CachedArray

class Maximum
  calculate: (array) -> 
    try @set x for x in array
    @get()
  constructor: (@_class = Number, @_value = undefined) -> 
  get: -> @_value
  set: (n) ->
    unless n >= @_value
      throw new RangeError "#{n} must be at least #{@_value}."
    unless (@_class.check? n) or n instanceof @_class or  typeof n is @_class.name
      throw new TypeError "#{n} must be a #{@_class.name}."
    @_value = n if n > @value or not @value?
    
root.Maximum = Maximum

###
Object.defineProperty(Array::, 'find',
    enumerable: false,
    configurable: true,
    writable: true,
    value: (predicate, thisArg = undefined) ->
      throw new TypeError 'Array.prototype.find called on null or undefined' unless @? 
      throw new TypeError 'predicate must be a function' unless typeof predicate is 'function'
      list = Object(this)
      (return el if predicate.call thisArg, el, i, list) for el, i in list
      return undefined
) unless Array::find?
###