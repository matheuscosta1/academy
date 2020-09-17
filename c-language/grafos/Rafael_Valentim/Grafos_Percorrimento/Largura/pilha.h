#ifndef PILHA_H
#define PILHA_H
#define isPilhaVazia(p) (p->bottom == NULL)

typedef struct pilha_ Pilha;
typedef struct vertice_ Vertice;

Pilha * makePilha();
int push(Pilha *p, int t);
int pop(Pilha *p);
#endif //PILHA_H
