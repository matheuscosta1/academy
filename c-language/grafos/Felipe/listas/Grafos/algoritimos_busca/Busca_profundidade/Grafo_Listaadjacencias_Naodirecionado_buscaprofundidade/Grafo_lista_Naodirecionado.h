#ifndef GRAFO_MATRIZ_H_INCLUDED
#define GRAFO_MATRIZ_H_INCLUDED


typedef struct grafo Grafo;
typedef struct no No;

Grafo* Cria_grafo(int vertices);
int Insere_Aresta(Grafo* g,int v1,int v2,int peso);
int Verifica_Aresta(Grafo* g,int v1,int v2);
int Remove_Aresta(Grafo* g,int v1,int v2);
int Consulta_Aresta(Grafo* g,int v1,int v2,int* peso);
void Libera_Grafo(Grafo**g);
void mostra_adjacentes(Grafo* g,int v);
void mostra_grafo(Grafo* g);
int Qtd_vertices(Grafo* g);
int Qtd_arestas(Grafo* g);
int Grau_vertice(Grafo* g,int v);
void Busca_profundidadeaux(Grafo* g,int v,int* visitados);
int Busca_profundidade(Grafo* g,int vertice);
int Todos_Busca_profundidade(Grafo* g);
int Busca_profundidadeIterativa(Grafo* g,int vertice);
#endif // GRAFO_MATRIZ_H_INCLUDED
