#include <stdio.h>
#include <stdlib.h>
#include "ABB.h"

int main()
{
    Registro G;
    Arv A = Cria_arvore();
    Arv B = Cria_arvore();
    G = Cria_Registro(19,NULL, 0, 0);
    insere_ord(&A,G);

    G = Cria_Registro(55,10, 0,0);
    insere_ord(&A,G);

    G = Cria_Registro(35,NULL, 0,0);
    insere_ord(&A,G);

    G = Cria_Registro(17,NULL, 0,0);
    insere_ord(&A,G);

    G = Cria_Registro(22,NULL, 0,0);
    insere_ord(&A,G);

    G = Cria_Registro(10,NULL, 0,0);
    insere_ord(&A,G);

    exibe_arvore(A);
    printf("\n");
    exibe_ord(A);

    libera_arvore(&B);
    libera_arvore(&A);
}
