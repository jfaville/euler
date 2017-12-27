###
Brute Force Method
###
generalize = (func) -> (base, reducends...) -> reducends.reduce func, base
sum = generalize (a, b) -> a + b
union = generalize (a, b) -> a.concat (el for el in b when el not in a)
    
multiplesInRange = (factors..., range) -> 
    union ((x for x in range by factor) for factor in factors)...

console.log sum multiplesInRange(3, 5, [0...1000])...

###
Formulaic Method
###
console.log sum multiplesInRange(3, 5, [0...1000])...