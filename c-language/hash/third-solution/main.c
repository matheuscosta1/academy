#include <stdio.h>
#include <stdlib.h>
#include "TabelaHash.h"
#include "utils.h"

void showMenu(int *);

void cria_aluno();
void liberar_hash(Hash *ha);
int insere_duplo_hash(Hash *ha);
int busca_hash_duplo(Hash *ha);
void mostrarDuploHash(Hash *ha);
void mostrarEncadeada(Hash *ha);

int main(int argc, char const *argv[]){
    int n, op;
    int tamanho = 1024;
    Hash *tabela = criaHash(tamanho);

    do{
        showMenu(&op);
        switch(op){
            case 1: liberar_hash(tabela); break;
            case 2: insere_duplo_hash(tabela); break;
            case 3: busca_hash_duplo(tabela); break;
            case 4: mostraDuploHash(tabela); break;
            case 5: mostrarEncadeada(tabela); break;
            case 6: criaAluno(); break;
        }
        if(op!= 7){
            printf("Pressione qualquer tecla para continuar...");
            setbuf(stdin, NULL);
            getchar();
        }
    } while(op != 7);

    return 0;
}

void showMenu(int *op){
    printInBlock("Menu", 0);
    printInBlockN( 1, "Libera tabela", 0);
    printInBlockN( 2, "Insere duplo hash", 0);
    printInBlockN( 3, "Busca hash duplo", 0);
    printInBlockN( 4, "Mostra duplo hash", 0);
    printInBlockN( 5, "Mostrar Encadeada", 0);
    printInBlockN( 6, "Cria aluno", 0);
    printInBlockN( 7, "Sair", 1);

    printf("Digite a opção desejada: ");
    setbuf(stdin, NULL);
    scanf("%d", op);
    setbuf(stdin, NULL);
    printf("\n");
}

void cria_aluno(){
    printInBlock("2. Cria aluno", 1);
    Aluno *a1 = criaAluno();
}

void liberar_hash(Hash *ha) {
    printInBlock("3. Liberar hash", 1);
    liberaHash(&ha);
}

int insere_duplo_hash(Hash *ha) {
    printInBlock("3. Insere duplo hash", 1);
    struct aluno a1;
    insereHash_DuploHash(&ha, a1);
}

int busca_hash_duplo(Hash *ha) {
    printInBlock("4. Busca hash duplo", 1);
    int matricula; struct aluno a1;
    scanf("Entre com a matricula: %d", &matricula);
    buscaHash_duploHash(ha, matricula, &a1);
}

void mostrarDuploHash(Hash *ha) {
    printInBlock("5. Imprimir duplo hash", 1);
    mostraDuploHash(ha);
}

void mostrarEncadeada(Hash *ha){
    printInBlock("6. Imprimir duplo hash", 1);
    mostraEncadeada(ha);
}
