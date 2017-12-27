import types
class ArgumentPrinter(object):
    def __init__(self, f):
        self.function = f
    def __call__(self, *args):
        print(args)
        return self.function(*args)
    def __get__(self, instance, cls=None):
        return types.MethodType(self, instance)

def printargs(func):
    return ArgumentPrinter(func)

@printargs
def bar(arg):
    print(arg)

class Foo(object):
    def __init__(self):
        pass
    @printargs
    def method(self, n):
        print(self, n)

foo = Foo()
foo.method(20)
bar(30)
# prints (20,)
# then raises a TypeError because `method` is missing the positional argument `bar`