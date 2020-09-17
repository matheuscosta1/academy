from unittest import TestCase, main

def eh_par(val:int) -> bool:
    """
     Função que verifica se o número é par
    """
#    try:
#        return True if val % 2 == 0 else False
#    except TypeError:
#        return False
#
    if isinstance(val, int) or isinstance(val, float):
        return True if val % 2 == 0 else False
    else: 
        return False

class Testes(TestCase):
    def test_par(self):
        self.assertEqual(eh_par(2), True)

    def test_impar(self):
        self.assertEqual(eh_par(3), False)

    def test_string(self):
        self.assertEqual(eh_par('string'), False)

    def test_float(self):
        self.assertEqual(eh_par(5.0), False)
        
if __name__ == '__main__':
    main()
