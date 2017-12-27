"""
Lattice Paths
Project Euler Problem 15

Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.


How many such routes are there through a 20×20 grid?

Usage:
    problem15.py <grid-dimension>
"""
from docopt import docopt
from time import clock
from utils import combinationsof, nitems
    
def routesThroughSquareGrid(dimension):
    """
    Moving from top left to bottom right only going right and down.
    """
    n = nitems(dimension * 2)
    combos = combinationsof(n, dimension)
    return len(combos)
  
if __name__ == '__main__':
    args = docopt(__doc__)
    n = int(args['<grid-dimension>'])
    start = clock()
    print(routesThroughSquareGrid(n))
    end = clock()
    print("Time elapsed: {}s".format(end - start))