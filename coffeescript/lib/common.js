var EulerProblem, root;

root = typeof exports !== "undefined" && exports !== null ? exports : window;

EulerProblem = (function() {
  function EulerProblem() {}

  EulerProblem.solution = function() {
    throw new Error("This problem is unsolved!");
  };

  EulerProblem.solve = function() {
    var delta, solution, start;
    start = new Date();
    solution = this.solution();
    delta = new Date() - start;
    console.log("" + solution + " was calculated in " + delta + " ms.");
    return solution;
  };

  return EulerProblem;

})();

root.EulerProblem = EulerProblem;