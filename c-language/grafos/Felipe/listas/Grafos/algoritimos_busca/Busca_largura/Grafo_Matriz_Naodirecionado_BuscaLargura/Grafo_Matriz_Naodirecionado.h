#ifndef GRAFO_MATRIZ_H_INCLUDED
#define GRAFO_MATRIZ_H_INCLUDED


typedef struct grafo Grafo;


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
int Busca_Largura(Grafo* g,int vertice);
int Todosbusca_Largura(Grafo* g);
int Busca_LarguraRecursivo(Grafo* g,int v);
void Busca_larguraaux(Grafo* g,int v,int* visitados);
#endif // GRAFO_MATRIZ_H_INCLUDED
