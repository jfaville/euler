import time

class EulerProblem:
    def __init__(self, getInput, *solutions):
        self.getInput = getInput
        self.solutions = solutions
    def solve(self, *arguments):
        solution = None
        problemInput = self.getInput() if hasattr(self.getInput, '__call__') else self.getInput
        for method in self.solutions:
            start = time.clock()
            solution = method(*arguments, **problemInput)
            delta = time.clock() - start
            print ("%s was calculated by %s in %i ms." % 
                  (solution, method.__name__, delta))
        return solution