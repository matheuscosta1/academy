#include <stdio.h>
#include <stdlib.h>
#include "arvore_generica.h"
#include "fila.h"
#include "utils.h"

void showMenu(int *);

void imprimir_pre_Ordem(Arv arv);
void imprimir_pos_Ordem(Arv arv);
void numero_nos_folhas(Arv arv);
void e_grau_arvore(Arv arv);
void limpar_arvore(Arv *arv);
void altura_no_arvore(Arv arv, int elem);
void quantidade_nos_Grau(Arv arv);
void exibir_arvore(Arv arv);

int main(int argc, char const *argv[]){
    int n, op;

    /** Nos exemplos**/
    Arv A = cria_arvore(1);
    Arv B = cria_arvore(2);
    Arv C = cria_arvore(3);
    Arv D = cria_arvore(4);
    Arv E = cria_arvore(5);
    Arv F = cria_arvore(6);
    Arv G = cria_arvore(7);
    Arv H = cria_arvore(8);
    Arv I = cria_arvore(9);
    Arv O = cria_arvore(20);
    Arv P = cria_arvore(25);
    insere(F,I);
    insere(F,H);
    insere(C,F);
    insere(C,E);
    insere(D,G);
    insere(A,O);
    insere(A,P);
    insere(A,D);
    insere(A,C);
    insere(A,B);
    Fila *f = criarFila();

    do{
        showMenu(&op);
        switch(op){
            case 1: imprimir_pre_Ordem(A); break;
            case 2: imprimir_pos_Ordem(A); break;
            case 3: percorre_nivel(A); break;
            case 4: numero_nos_folhas(A); break;
            case 5: e_grau_arvore(A); break;
            case 6: quantidade_nos_Grau(A); break;
            case 7: altura_no_arvore(A, 8); break;
            case 8: limpar_arvore(&A); break;
        }
        if(op!= 9){
            printf("Pressione qualquer tecla para continuar...");
            setbuf(stdin, NULL);
            getchar();
        }
    }while(op != 9);

    return 0;
}

void showMenu(int *op){
    printInBlock("Menu", 0);
    printInBlockN( 1, "Exibir a arvore em pre Ordem", 0);
    printInBlockN( 2, "Exibir a arvore em pos Ordem", 0);
    printInBlockN( 3, "Exibir a arvore em largura", 0);
    printInBlockN( 4, "Exibir quantidade de nos folhas", 0);
    printInBlockN( 5, "Exibir o grau da arvore", 0);
    printInBlockN( 6, "Exibir a quantidade de nos com determinado grau", 0);
    printInBlockN( 7, "Altura de um dado no", 0);
    printInBlockN( 8, "Limpar arvore", 0);
    printInBlockN( 9, "Sair", 1);

    printf("Digite a opção desejada: ");
    setbuf(stdin, NULL);
    scanf("%d", op);
    setbuf(stdin, NULL);
    printf("\n");
}

void exibir_arvore(Arv arv){
    printInBlock("1. Arvore impressa em pre Ordem", 1);
    printf("\n"); exibe_arvore(arv); printf("\n\n");
}

void imprimir_pre_Ordem(Arv arv){
    printInBlock("1. Arvore impressa em pre Ordem", 1);
    printf("\n"); pre_ordem(arv); printf("\n\n");
}

void imprimir_pos_Ordem(Arv arv) {
    printInBlock("2. Arvore impressa em pos Ordem", 1);
    printf("\n"); pos_ordem (arv); printf("\n");
}

void percorre_nivel(Arv arv) {
    printInBlock("3. Percorre a arvore em largura", 1);
    largura(arv);
}

void numero_nos_folhas(Arv arv) {
    printInBlock("4. Quantidade de nos folhas", 1);
    int a = no_folha(arv);
    printf("\n[%d] nos folhas\n\n", a);
}

void e_grau_arvore(Arv arv) {
    printInBlock("5. Grau da arvore", 1);
    int a = grau_arvore(arv);
    printf("\n[%d] eh o grau da arvore\n\n", a);
}

void quantidade_nos_Grau(Arv arv){
    printInBlock("6. Quantidade de nos que possuem o dado grau como entrada", 1);
    int d;
    printf("\nEntre com um grau: ");
    scanf("%d", &d);
    int a = quantidade_nos(arv, d);
    printf("\n[%d] eh a quantidade de nos com o grau %d \n\n", a, d);
}

void altura_no_arvore(Arv arv, int elem){
    printInBlock("7. Altura de um dado no", 1);
    int a = altura_no(arv, elem);
    printf("\n[%d] eh a altura do no %d \n\n", a, elem);
}

void limpar_arvore(Arv *arv){
    printInBlock("8. Liberar arvore", 1);
    libera_arvore(&arv);
}
