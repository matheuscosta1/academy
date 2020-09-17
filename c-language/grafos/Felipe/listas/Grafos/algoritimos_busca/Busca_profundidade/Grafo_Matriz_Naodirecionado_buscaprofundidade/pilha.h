#ifndef PILHA_H_INCLUDED
#define PILHA_H_INCLUDED


typedef struct pilha Pilha;

int Tamanho_Pilha(Pilha* p);
Pilha* Cria_Pilha();
int Empilha(Pilha* p,int i);
int Desempilha(Pilha* p,int* i);
int Verifica_Elem(Pilha* p,int i);
void Libera_Pilha(Pilha**p);

#endif // PILHA_H_INCLUDED
