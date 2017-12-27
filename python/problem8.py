from EulerProblem import EulerProblem

#LARGEST PRODUCT IN A SERIES
#Given: (int) longNumber, (int) n
#Calculate: (int) greatestProductOfNAdjacentDigits

def digitsOf(n): return [int(x) for x in str(int(n))]

def findGreatestProductInSequence(sequence, n):
    if len(sequence) < n: return None
    
    def greatestProductInSequence(sequence):
        greatestProduct = 0
        i = 0; product = 1
        while i < len(sequence):
            number = sequence[i]
            if number is 0:
                return max(greatestProduct, 
                           greatestProductInSequence(sequence[i+1:]))
            product *= number
            if i >= n - 1:
                if i >= n:
                    product /= sequence[i - n]
                if product > greatestProduct:
                    greatestProduct = product
                    indexOfGreatestProduct = i - (n - 1)
            i += 1
        return greatestProduct
            
    return greatestProductInSequence(sequence)
    

def getInput(): 
    return {
        "series": int(raw_input('Provide the integer whose digits are to be considered: ')),
        "n": int(raw_input('Provide the number of adjacent digits to consider: '))
    }
    
def bruteForce(series, n): 
    return findGreatestProductInSequence(digitsOf(series), n)


if __name__ == '__main__':
    problem8 = EulerProblem(getInput, bruteForce)
    problem8.solve()