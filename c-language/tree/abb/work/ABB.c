#include "ABB.h"
#include "Registro.h"
#include <stdio.h>
#include <stdlib.h>


struct No{

  Registro info;

  Arv sae;
  Arv sad;

};



Arv Cria_arvore()
{
    return NULL;
}

int Arvore_Vazia(Arv a)
{
    return (!a);
}

int insere_ord(Arv *a,Registro g)
{
    if(a==NULL)
        return 0;

    if((*a)==NULL)
    {
        (*a)=(Arv)malloc(sizeof(struct No));
        (*a)->info=g;
        (*a)->sae=NULL;
        (*a)->sad=NULL;
        return 1;
    }

    if(Menor_Registro((*a)->info,g)==g)
    {
       return insere_ord(&((*a)->sae),g);

    }

    return insere_ord(&((*a)->sad),g);


}


Arv remove_ord(Arv* a,int chave)
{
    if(a==NULL)
        return NULL;

    if((*a)==NULL)
        return NULL;

    if(chave<get_chave((*a)->info))
    {
        return remove_ord(&((*a)->sae),chave);
    }
    if(chave>get_chave((*a)->info))
    {
        return remove_ord(&((*a)->sad),chave);
    }

    Arv aux;
    if((*a)->sae==NULL && (*a)->sad==NULL)//folha;
    {

       aux=(*a);
        (*a)=NULL;
        return aux;
    }
    if(((*a)->sae==NULL) && (*a)->sad!=NULL)//derivaçao com 1 filho
    {
        aux=(*a);
        (*a)=(*a)->sad;
        return aux;
    }

    if((*a)->sae!=NULL && (*a)->sad==NULL)//derivaçao com um filho
        {
            aux=(*a);
            (*a)=(*a)->sae;
            return aux;
        }

     //derivaçao com dois fllhos

     aux=(*a)->sae;

     while(aux->sad!=NULL)
     {
         aux=aux->sad;
     }

    Registro temp= (*a)->info;
    (*a)->info=aux->info;
    aux->info = temp;

    return remove_ord(&((*a)->sae),chave);
}


Arv busca_bin(Arv a,int chave)
{
    if(a==NULL)
        return NULL;

    if(chave==get_chave(a->info))
    return a;

    if(chave<get_chave(a->info))
    {
        return busca_bin(a->sae,chave);
    }

    return busca_bin(a->sad,chave);



}

void exibe_arvore(Arv a)
{
    if(a==NULL)
    {
        printf("<>");
        return;
    }

    printf("<%d ",get_chave(a->info));
    exibe_arvore(a->sae);
    exibe_arvore(a->sad);
    printf(">");


}

void exibe_ord(Arv a)
{
    if(a==NULL)
    {
        return;
    }

    exibe_ord(a->sae);
    imprime(a->info);
    printf("\n");
    exibe_ord(a->sad);


}

void libera_arvore(Arv* a)
{
    if(a==NULL || (*a)==NULL)
        return;


    libera_arvore(&((*a)->sae));
    libera_arvore(&((*a)->sad));
    free((*a));
    (*a)=NULL;


}



Registro Maior(Arv a)
{
    if(a==NULL)
        return NULL;


    return Maior_Registro(Maior(a->sad),a->info);

}

int de_maior(Arv a)
{

    if(a==NULL)
        return 0;


    if(get_idade(a->info)<18)
    return de_maior(a->sad);

    if(get_idade(a->info)==18)
        return 1+de_maior((a->sad));

    return 1+(de_maior(a->sad)+de_maior(a->sae));


}

int qtde_alunos(Arv a,int ini,int fim)
{
    if(a==NULL)
        return 0;


    int idade=get_idade(a->info);


    if(idade<ini)
    return qtde_alunos(a->sad,ini,fim);


    if(idade>fim)
        return qtde_alunos(a->sae,ini,fim);

    return 1+ (qtde_alunos(a->sae,ini,fim))+(qtde_alunos(a->sad,ini,fim));

}

int um_filho(Arv a)
{
    if(a==NULL)
        return 0;

    if((a->sae)==NULL && (a->sad)==NULL)
        return 0;

    if((a->sae)==NULL && (a->sad)!=NULL)
        return 1+(um_filho(a->sad));

   if((a->sae)!=NULL && (a->sad)==NULL)
            return 1+(um_filho(a->sae));

   return (um_filho(a->sae))+(um_filho(a->sad));


}

int folhas(Arv a)
{
    if(a==NULL)
        return 0;

    if((a->sae)==NULL && (a->sad)==NULL)
        return 1;

    return folhas(a->sae)+folhas(a->sad);
}

int intermediarios(Arv a)
{
    if(a==NULL)
        return 0;

    if((a->sae)==NULL && (a->sad)==NULL)
       return 0;

     return 1+intermediarios(a->sae)+intermediarios(a->sad);
}


int completa(Arv a)
{
    if(folhas(a)==(intermediarios(a)+1))
        return 1;


    return 0;
}

int altura_arv(Arv a)
{

    if(a==NULL)
        return -1;

    int altura1= altura_arv(a->sae);
    int altura2= altura_arv(a->sad);

    if(altura1>=altura2)
        return 1+altura1;


   return 1+altura2;

}

Arv juntar(Arv a1,Arv a2)
{
    if(a1==NULL && a2==NULL)
        return NULL;

    if(a1==NULL && a2!=NULL)
        return a2;

    if(a1!=NULL && a2==NULL)
        return a1;
Arv b=Cria_arvore();

    b=juntar(b,a1->sae);
    b=juntar(b,a1->sad);
    b=juntar(b,a2->sad);
    b=juntar(b,a2->sae);



      insere_ord(&b,a1->info);
      insere_ord(&b,a2->info);






   return b;

}
