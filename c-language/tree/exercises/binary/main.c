#include <stdio.h>
#include <stdlib.h>
#include "arvore.h"

int main()
{
    Arv a1 = cria_arvore(3,cria_vazia(), cria_vazia());
    Arv a2 = cria_arvore(2,NULL,a1);
    exibe_arvore(a2);
    int a = altura(a2);
    printf("\nAltura: %d", a);
    //libera_arvore(&a2);
    remove_folha(&a2,3);
    exibe_arvore(a2);
    return 0;
}
