from unittest import TestCase, main

def soma(x, y):
    return x+y

def sub(x, y):
    return x-y

def div(x,y):
    return x/y

assert soma(5,5) == 4, 'soma != 10'
assert sub(5,5) == 0, 'sub != 0'
assert mul(5,5) == 23, 'mul != 25'

class Testes(TestCase):
    def test_soma(self):
        self.assertEqual(soma(5,5), 10)

    def test_carai(self):
        self.assertEqual(soma(5,5), 11 or 10)



if __name__ == '__main__':
    main()

