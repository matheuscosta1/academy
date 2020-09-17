#ifndef TABELAHASH_H_INCLUDED
#define TABELAHASH_H_INCLUDED

struct aluno{
    int matricula,idade;
    char nome[50];
    struct aluno *prox; ///Isso so eh usado na lista encadeada
};
typedef struct aluno Aluno;
typedef struct hash Hash;

Aluno *criaAluno();
Hash *criaHash(int TABLE_SIZE);
void liberaHash(Hash *ha);
void liberaHash_ListaEncadeada(Hash *ha);
int chaveDivisao(int chave,int TABLE_SIZE);
int chaveMultiplicacao(int chave,int TABLE_SIZE);
int duploHash(int h1,int chave,int i,int TABLE_SIZE);
int insereHash_DuploHash(Hash *ha,struct aluno al);
int buscaHash_duploHash(Hash *ha,int mat,Aluno *al);
int insereHash_ListaEncadeada(Hash *ha,struct aluno al);
int buscaHash_ListaEncadeada(Hash *ha,struct aluno *al,int mat);
int removeHash_ListaEncadeada(Hash *ha,int mat);
void mostraEncadeada(Hash *ha);
void mostraDuploHash(Hash *ha);

#endif // TABELAHASH_H_INCLUDED
