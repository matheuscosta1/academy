#ifndef ARVORE_BIN_BUS_HASH_H_INCLUDED
#define ARVORE_BIN_BUS_HASH_H_INCLUDED

typedef struct no *Arvore;

struct aluno {
    int matricula, idade;
    char nome[50];
};

Arvore cria_vazia();
void libera_arvore (Arvore* arv);
void exibe_arvore (Arvore arv);
void exibe_ordenado (Arvore arv);
int insere_ordenado(Arvore* arv, Aluno reg);
int remove_ordenado(Arvore* arv, int chave);
int busca_bin (Arvore arv, int chave);

#endif // ARVORE_BIN_BUS_HASH_H_INCLUDED
