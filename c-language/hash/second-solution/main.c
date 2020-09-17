#include <stdio.h>
#include <stdlib.h>
#include "arvore_bin_bus_hash.h"
#include "utils.h"

void showMenu(int *);

void libera_arvore2(Arvore *arv);
void busca_binaria(Arvore arv);
void exibe_ordenado2(Arvore arv);
void exibe_arvore(Arvore arv);
int insere_ordenado2(Arvore *arv, struct aluno a1);
int remove_ordenado2(Arvore *arv);

int main(int argc, char const *argv[]){
    int n, op;

    /** Nos exemplos**/
    Arv A = cria_vazia();
    struct aluno al, a[4] = {{12352,"Andre",9.5,7.8,8.5},
                         {7894,"Ricardo",7.5,8.7,6.8},
                         {3451,"Bianca",9.7,6.7,8.4},
                         {5293,"Ana",5.7,6.1,7.4}};

    do{
        showMenu(&op);
        switch(op){
            case 1: insere_ordenado2(&A, a1); break;
            case 2: libera_arvore2(&A); break;
            case 3: busca_binaria(A); break;
            case 4: exibe_ordenado2(A); break;
            case 5: exibe_arvore(A); break;
            case 6: remove_ordenado2(&A); break;
        }
        if(op!= 7){
            printf("Pressione qualquer tecla para continuar...");
            setbuf(stdin, NULL);
            getchar();
        }
    }while(op != 7);

    return 0;
}

void showMenu(int *op){
    printInBlock("Menu", 0);
    printInBlockN( 1, "Insere ordenado", 0);
    printInBlockN( 2, "Libera arvore", 0);
    printInBlockN( 3, "Busca binaria", 0);
    printInBlockN( 4, "Exibe ordenado", 0);
    printInBlockN( 5, "Exibe arvore", 0);
    printInBlockN( 6, "Remover ordenado", 0);
    printInBlockN( 7, "Sair", 1);

    printf("Digite a opção desejada: ");
    setbuf(stdin, NULL);
    scanf("%d", op);
    setbuf(stdin, NULL);
    printf("\n");
}

void libera_arvore2(Arvore *arv){
    printInBlock("1. Liberar a arvore", 1);
    libera_arvore(&arv);
}

void exibe_ordenado2(Arvore arv){
    printInBlock("2. Exibe ordenado", 1);
    exibe_ordenado(arv);
}

void exibe_arvore(Arvore arv) {
    printInBlock("3. Exibe arvore", 1);
    exibe_arvore(arv);
}

void busca_binaria(Arvore arv) {
    printInBlock("3. Busca binaria", 1);
    int chave;
    printf("Entre com uma chave: ");
    scanf("%d", &chave);
    busca_bin(arv, chave);
}

insere_ordenado2(Arvore *arv, struct aluno a1){
    printInBlock("3. Inserir ordenado", 1);
    int i;
    struct aluno a[4];
    for(i=0; i < 4; i++){
        insere_ordenado(&arv, a[i]);
    }
}

int remove_ordenado2(Arvore *arv){
    printInBlock("3. Inserir ordenado", 1);
    int chave;
    printf("Entre com uma chave: ");
    scanf("%d", &chave);
    remove_ordenado(&arv, chave);
}
