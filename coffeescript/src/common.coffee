root = exports ? window

class EulerProblem
    @solve: (args...) -> 
        solution
        for key, func of @ when key isnt "solve" and key.indexOf("_") isnt 0
            start = new Date()
            solution = func(args...)
            delta = new Date() - start
            console.log "#{key}: #{solution} was calculated in #{delta} ms."
        solution ? throw new Error "This problem is unsolved!"
    
root.EulerProblem = EulerProblem