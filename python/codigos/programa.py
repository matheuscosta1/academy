if __name__ == '__main__':

    n1 = int(input())
    n3 = int(input())
    n4 = int(input())
    n6 = int(input())

    # n1 par, n2 impar, n3 par, n4 impar, n5 par, n6 impar

    if n1 % 2 == 0:
        n2_impar = True
        n5_impar = False
    else:
        n2_impar = False
        n5_impar = True

    print("Primeiro:", "{:02}".format(n1))
    print("Terceiro:", "{:02}".format(n3))
    print("Quarto:", "{:02}".format(n4))
    print("Sexto:", "{:02}".format(n6))
    print("Lista de apostas:")

    n2, n5, soma = 0, 0, 0

    for iterador_i in range(n1 + 1, n3):
        if n2_impar:
            if not (iterador_i % 2 == 0):
                n2 = iterador_i
            else:
                n2 = 0
        else:
            if iterador_i % 2 == 0:
                n2 = iterador_i
            else:
                n2 = 0

        for iterador_j in range(n4 + 1, n6):
            soma = 0
            if n5_impar:
                if not (iterador_j % 2 == 0):
                    n5 = iterador_j
                else:
                    n5 = 0
            else:
                if iterador_j % 2 == 0:
                    n5 = iterador_j
                else:
                    n5 = 0

            soma = n1 + n2 + n3 + n4 + n5 + n6

            if not(soma % 7 == 0 or soma % 13 == 0) and not(n2 == 0 or n5 == 0):
                print("{:02} - {:02} - {:02} - {:02} - {:02} - {:02}".format(n1, n2, n3, n4, n5, n6))