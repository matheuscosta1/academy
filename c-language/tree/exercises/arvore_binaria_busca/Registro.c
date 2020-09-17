#include "Registro.h"
#include <stdio.h>
#include <stdlib.h>

struct Reg {
  int idade;
  int chave;
  char nome;
  float real;
};

Registro Cria_Registro(int idade, int chave, float real, char nome)
{
    Registro G=(Registro)malloc(sizeof(struct Reg));

    if(G == NULL){return G;}


    G -> idade = idade;
    G -> chave = chave;
    G -> nome  = nome;
    G -> real  = real;

    return G;
}

Registro Maior_Registro(Registro A,Registro B)
{

    if(A==NULL && B!=NULL)
        return B;

    if(B==NULL && A!= NULL)
        return A;

    if(A==NULL && B==NULL)
    return NULL;

    if((A->idade)<=(B->idade))
        return B;

    return A;
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
}
