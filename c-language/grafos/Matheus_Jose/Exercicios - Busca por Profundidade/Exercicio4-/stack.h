#ifndef STACK_H_INCLUDED
#define STACK_H_INCLUDED


typedef struct item Item;
typedef struct pilha Pilha;
Pilha *criaPilha();
int vazia (Pilha *x);
void empilhar (float i, Pilha *x);
float desempilhar (Pilha *x);
void freeStack (Pilha *x);
void printStack (Pilha *x);
#endif // STACK_H_INCLUDED
