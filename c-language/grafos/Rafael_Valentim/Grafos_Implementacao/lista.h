#ifndef LISTA_H_INCLUDED
#define LISTA_H_INCLUDED

typedef struct item Item;
typedef struct lista Lista;

Lista *criar_lista();
int vazia(Lista *a);
Item * criar_item();
void inserir_inicio(Lista *a, int, int);
void inserir_final(Lista *, int, int);
int contem(Lista *l, int i);
int buscar_elemento(Lista *l, int elem, int *item);
int remover_elemento(Lista * l, int elmt);
void mostrar_lista(Lista *a);
void liberar_lista(Lista **l);

#endif // LISTA_H_INCLUDED
