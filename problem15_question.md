When using a decorator on an instance method in Python, the `self` argument which would have been passed to the undecorated method is always the first argument passed to the function that the decorator returns. 

As an example, in the code below a `printargs` decorator returns a wrapper function that prints all its arguments before passing them to the decorated function: when the decorator is used on a method of the class `Foo`, the instance that the method is being called from is printed before the other arguments of the method.

    def printargs(f):
        def inner(*args):
            print(args)
            return f(*args)
        return inner
    
    class Foo(object):
        def __init__(self):
            pass
        @printargs
        def method(self, bar):
            pass
    
    foo = Foo()
    foo.method(20) 
    
    # prints (<__main__.Foo object at 0x7eff9e4b8550>, 20)
    
However, when a callable object is returned by the decorator instead of a function, that `self` argument is mysteriously missing.

    class ArgumentPrinter(object):
        def __init__(self, f):
            self.function = f
        def __call__(self, *args):
            print(args)
            return self.function(*args)

    def printargs(func):
        return ArgumentPrinter(func)

    class Foo(object):
        def __init__(self):
            pass
        @printargs
        def method(self, bar):
            pass
        
    foo = Foo()
    foo.method(20)
    
    # prints (20,)
    # then raises a TypeError because `method` is missing the positional argument `bar`
    
I would have expected the behavior of these two decorators to be identical. Does anyone know what's going on?