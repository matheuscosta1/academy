#include "Registro.h"
#include <stdio.h>
#include <stdlib.h>

struct Reg {
  int idade;
  char* nome;
  char* curso;
};

Registro Cria_Registro(int idade,char* nome,char* curso)
{
    Registro g=(Registro)malloc(sizeof(struct Reg));

    if(g==NULL){return g;}


    g->idade=idade;
    g->nome=nome;
    g->curso=curso;

    return g;
}

Registro Maior_Registro(Registro a,Registro b)
{

     if(a==NULL && b!=NULL)
        return b;

         if(b==NULL && a!= NULL)
        return a;

if(a==NULL && b==NULL)
    return NULL;

    if((a->idade)<=(b->idade))
        return b;

    return a;
}


Registro Menor_Registro(Registro a,Registro b)
{
    if(a==NULL && b==NULL)
        return NULL;
    if(a!=NULL && b==NULL )
        return a;
    if(a==NULL && b!=NULL)
        return b;

    if((a->idade)>=(b->idade))
        return b;

    return a;
}

char* get_nome(Registro a)
{
    if(a==NULL)
        return NULL;

    return a->nome;
}

int get_idade(Registro a)
{
     if(a==NULL)
        return -1;
    return a->idade;
}


void Libera_Registro(Registro* g)
{
    if(g==NULL)
        return;

    if((*g)==NULL)
        return;

    free((*g)->nome);
    free((*g)->curso);
    free((*g));

    (*g)=NULL;
}

int get_chave(Registro a)
{

    if(a==NULL)
        return -1;

    return a->idade;
}
void imprime(Registro a)
{
    if(a==NULL)
        return;
    printf("idade:%d\n",a->idade);
    printf("Nome:%s\n",a->nome);
    printf("Curso:%s\n",a->curso);
}

char* get_curso(Registro a)
{
    return a->curso;
}
