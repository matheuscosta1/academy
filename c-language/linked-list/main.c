#include <stdio.h>
#include <stdlib.h>
#include "lista.h"

int main()
{
    Lista *l1 = criarLista();
    inserirOrdenado(l1, 103);
    inserirOrdenado(l1, 103);
    //inserirOrdenado(l1, 0);
    //inserirOrdenado(l1, 20);
    //inserirOrdenado(l1, 3);
    //inserirOrdenado(l1, 100);
    imprimir(l1);
    printf("A lista tem %d numeros 3\n", contaOcorrencias(l1,3));
    printf("A lista tem %d numeros\n", tamanho(l1));
    printf("O terceiro elemento = %d", retornaN_esimo(l1, 2));
    /*
    int ultimo;

    if (ultimoElemento(l1, &ultimo))
        printf("Ultimo: %d\n", ultimo);
    else
        printf("Erro no ultimo!!!\n");
    inserirNoInicio(l1, 3);
    if (ultimoElemento(l1, &ultimo))
        printf("Ultimo: %d\n", ultimo);
    inserirNoInicio(l1, 2);
    if (ultimoElemento(l1, &ultimo))
        printf("Ultimo: %d\n", ultimo);
    inserirNoInicio(l1, 1);
    if (ultimoElemento(l1, &ultimo))
        printf("Ultimo: %d\n", ultimo);

    imprimir(l1);

    Lista *l2 = criarLista();
    int primeiro;
    if (primeiroElemento(l2, &primeiro))
        printf("\nPrimeiro: %d\n", primeiro);
    else
        printf("Erro no primeiro!!!\n");
    if (ultimoElemento(l2, &ultimo))
        printf("Ultimo: %d\n", ultimo);
    else
        printf("Erro no ultimo!!!\n");

    inserirNoFinal(l2, 4);
    if (primeiroElemento(l2, &primeiro))
        printf("Primeiro: %d\n", primeiro);
    if (ultimoElemento(l2, &ultimo))
        printf("Ultimo: %d\n", ultimo);
    inserirNoFinal(l2, 5);
    if (primeiroElemento(l2, &primeiro))
        printf("Primeiro: %d\n", primeiro);
    if (ultimoElemento(l2, &ultimo))
        printf("Ultimo: %d\n", ultimo);
    inserirNoFinal(l2, 6);
    if (primeiroElemento(l2, &primeiro))
        printf("Primeiro: %d\n", primeiro);
    if (ultimoElemento(l2, &ultimo))
        printf("Ultimo: %d\n", ultimo);

    imprimir(l2); printf("\n\n");

    imprimir(concatena(l1,l2));
    */
}
