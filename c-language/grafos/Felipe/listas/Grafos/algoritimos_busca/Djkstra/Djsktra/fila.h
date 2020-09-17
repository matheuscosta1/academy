#ifndef FILA_H_INCLUDED
#define FILA_H_INCLUDED

typedef struct fila Fila;

Fila* Cria_Fila();
int Insere_fila(Fila* f,int i);
int Remove_fila(Fila* f,int* i);
int Libera_fila(Fila** f);
int Tamanho_fila(Fila* f);
void Imprime_fila(Fila* f);

#endif // FILA_H_INCLUDED
