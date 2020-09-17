#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "TabelaHash.h"

struct hash{
    int qtd,TABLE_SIZE;
    struct aluno **itens;
};

Aluno *criaAluno(){
    Aluno *a;
    a = (Aluno*)malloc(sizeof(Aluno));
    printf("Nome: ");
    scanf("%s",a->nome);
    printf("Idade: ");
    scanf("%d",&a->idade);
    printf("Matricula: ");
    scanf("%d",&a->matricula);
    a->prox = NULL;
    return a;
}

Hash *criaHash(int TABLE_SIZE){
    Hash *ha = (Hash*)malloc(sizeof(Hash));
    if(ha != NULL){
        int i;
        ha->TABLE_SIZE = TABLE_SIZE;
        ha->qtd = 0;
        ha->itens = (struct aluno**)malloc(TABLE_SIZE*sizeof(struct aluno*));
        if (ha->itens==NULL){
            free(ha);
            return NULL;
        }
        for (i=0;i<TABLE_SIZE;i++){
                ha->itens[i] = NULL;
        }
    }
    return ha;
}
void liberaHash(Hash *ha){
    if(ha!=NULL){
        for(int i=0; i< ha->TABLE_SIZE;i++){
            if(ha->itens[i] != NULL){
                free(ha->itens[i]);
            }
        }
        free(ha->itens);
        free(ha);
    }
}

void liberaHash_ListaEncadeada_temp(Aluno *a){
    if(a!=NULL){
        liberaHash_ListaEncadeada_temp(a->prox);
    }
    free(a);
}
void liberaHash_ListaEncadeada(Hash *ha){
    if(ha!=NULL){
        for(int i=0; i< ha->TABLE_SIZE;i++){
            if(ha->itens[i] != NULL){
                liberaHash_ListaEncadeada_temp(ha->itens[i]);
            }
        }
        free(ha->itens);
        free(ha);
        ha=NULL;
    }
}

int chaveDivisao(int chave,int TABLE_SIZE){
    return (chave & 0x7FFFFFFF) % TABLE_SIZE;
}

int chaveMultiplicacao(int chave,int TABLE_SIZE){
    float A = 0.6180339887;
    float val = chave * A;
    val = val - (int) val;
    return (int)(TABLE_SIZE * val);
}

int duploHash(int h1,int chave,int i,int TABLE_SIZE){
    int h2 = chaveDivisao(chave,TABLE_SIZE-1)+1;
    return ((h1 + i*h2) & 0x7FFFFFFF) % TABLE_SIZE;
}

int insereHash_DuploHash(Hash *ha,struct aluno al){
    if(ha == NULL || ha->qtd == ha->TABLE_SIZE)return 0;
    int chave = al.matricula;
    int i,pos,newPos;
    pos = chaveMultiplicacao(chave,ha->TABLE_SIZE);
    for(i=0;i<ha->TABLE_SIZE;i++){
        newPos = duploHash(pos,chave,i,ha->TABLE_SIZE);
        if(ha->itens[newPos]==NULL){
            struct aluno *novo;
            novo = (struct aluno*)malloc(sizeof(struct aluno));
            if(novo==NULL)return 0;
            *novo = al;
            ha->itens[newPos] = novo;
            ha->qtd++;
            return 1;
        }
    }
    return 0;
}


int buscaHash_duploHash(Hash *ha,int mat,Aluno *al){
    if(al ==NULL)return 0;
    int i,pos,newPos;
    pos = chaveMultiplicacao(mat,ha->TABLE_SIZE);
    for(i=0;i<ha->TABLE_SIZE;i++){
        newPos = duploHash(pos,mat,i,ha->TABLE_SIZE);
        if(ha->itens[newPos]==NULL)return 0;
        if(ha->itens[newPos]->matricula == mat){
            *al = *(ha->itens[newPos]);
            return 1;
        }
    }
    return 0;
}

int insereHash_ListaEncadeada(Hash *ha,struct aluno al){
    if(ha==NULL || ha->qtd == ha->TABLE_SIZE)return 0;
    else{
        int pos;
        pos = chaveDivisao(al.matricula,ha->TABLE_SIZE);
        struct aluno *novo;
        novo = (struct aluno*)malloc(sizeof(struct aluno));
        if(novo == NULL)return 0;
        *novo = al;
        Aluno *aux;
        aux = ha->itens[pos];
        ha->itens[pos] = novo;
        novo->prox = aux;
        ha->qtd++;
        return 1;
    }
}

int buscaHash_ListaEncadeada(Hash *ha,struct aluno *al,int mat){
    if(ha==NULL)return 0;
    else {
        int pos = chaveDivisao(mat,ha->TABLE_SIZE);
        Aluno *aux;
        aux = ha->itens[pos];
        while(aux!=NULL && aux->matricula!=mat){
            aux = aux->prox;
        }
        if(aux==NULL)return 0;
        *al = *aux;
        return 1;
    }
}

int removeHash_ListaEncadeada(Hash *ha,int mat){
    if(ha==NULL)return 0;
    int pos = chaveDivisao(mat,ha->TABLE_SIZE);
    Aluno *aux;
    if(ha->itens[pos]->matricula == mat){
        Aluno *temp = ha->itens[pos];
        ha->itens[pos] = ha->itens[pos]->prox;
        free(temp);
        ha->qtd--;
        return 1;
    }
    else{
        aux = ha->itens[pos];
        while(aux->prox!=NULL && aux->prox->matricula!=mat){
            aux= aux->prox;
        }
        if(aux->prox==NULL)return 0;
        Aluno *aux2;
        aux2 = aux->prox;
        aux->prox = aux->prox->prox;
        free(aux2);
        ha->qtd--;
        return 1;
    }
}

void mostraEncadeada(Hash *ha){
    for (int i=0;i<ha->TABLE_SIZE;i++){
        if(ha->itens[i]==NULL)printf("NULL\n");
        else{
            Aluno *aux;
            aux = ha->itens[i];
            while(aux !=NULL){
                printf("%s  ",aux->nome);
                aux = aux->prox;
            }
            printf("NULL\n");

        }
    }
}

void mostraDuploHash(Hash *ha){
    for (int i=0;i<ha->TABLE_SIZE;i++){
        if(ha->itens[i]==NULL)printf("NULL\n");
        else{
            Aluno *aux;
            aux = ha->itens[i];
            while(aux !=NULL){
                printf("%s\n",aux->nome);
                aux = aux->prox;
            }

        }
    }
}
