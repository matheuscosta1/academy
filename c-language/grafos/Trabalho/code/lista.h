#ifndef LISTA_H_INCLUDED
#define LISTA_H_INCLUDED

typedef struct aresta_ Aresta;
typedef struct lista_ Lista;

Lista *criar_lista();
int vazia(Lista *a);
void inserir_inicio(Lista *a, int, int, double );
int contem(Lista *l, int i);
int buscar_elemento(Lista *l, int elem, int *item, double * dist);
int remover_elemento(Lista * l, int elmt);
void mostrar_lista(Lista *a);
int get_elemento(Lista *l, int posicao, int * vertice, int * capacidade, double * distancia);
int list_size(Lista *l);
void liberar_lista(Lista **l);

#endif // LISTA_H_INCLUDED
