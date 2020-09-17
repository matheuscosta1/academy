#include "avl.h"

struct ponto_de_rede
{
    char * nome;
    char * localizacao;
    double capacidade;
    //Chave
    double trafego;
};

struct no
{
    struct no *sae;
    struct no *sad;
    int fb;
    struct ponto_de_rede pdr;
};


Arvore criar_arvore(){

    return NULL;
}

int arvore_vazia(Arvore arv){ return arv == NULL;}

int insere_ordenado(Arvore * arv, int * bal, char * nome, char * loc, double cap, double traf){
        if(arv == NULL) return 0;
        int sucesso;

        if(*arv == NULL){
            Arvore arv_ = (Arvore) malloc(sizeof(No));
            
            if(arv_ == NULL) return 0;
            
            PontoDeRede * pdr = &(arv_->pdr);
    
            pdr->trafego = traf;
            pdr->capacidade = cap;
            pdr->nome = malloc(strlen (nome));
            if(pdr->nome == NULL){
                free(arv_);
                return 0;
            }
            strcpy(pdr->nome, nome);
            
            pdr->localizacao = malloc(strlen(loc));
            if(pdr->localizacao == NULL){
                free(pdr->nome);
                free(arv_);
                return 0;
            }
            strcpy(pdr->localizacao, loc);

            arv_->fb = 0;
            arv_->sae = NULL;
            arv_->sad = NULL;

            *arv = arv_;
            *bal = 1;
        }
        else if (traf <= (*arv)->pdr.trafego){
            sucesso = insere_ordenado(&(*arv)->sae, bal, nome, loc, cap, traf);
            if(sucesso == 0) return 0;
            if(*bal == 1){
                if((*arv)->fb == 1){
                    balancear_esquerda(arv);
                    *bal = 0;
                }else if ((*arv)-> fb == 0)
                {
                    (*arv)->fb = 1;
                }else{
                    (*arv)->fb = 0;
                    bal = 0;
                }
            }
            return 1;
        }else{
            sucesso = insere_ordenado(&(*arv)->sad, bal, nome, loc, cap, traf);
            if(sucesso == 0) return 0;
            if(*bal == 1){
                if((*arv)->fb == -1){
                    balancear_direita(arv);
                    *bal = 0;
                }else if ((*arv)-> fb == 0)
                {
                    (*arv)->fb = -1;
                }else{
                    (*arv)->fb = 0;
                    bal = 0;
                }
            }
            return 1;
        }
}

int balancear_esquerda(Arvore * arv){
    if((*arv)->sae->fb > 0) return rotacionar_direita(arv);
    else rotacionar_dir_esq(arv);
}

int balancear_direita(Arvore * arv){
    if((*arv)->sad->fb < 0) return rotacionar_esquerda(arv);
    else rotacionar_esq_dir(arv);
}

int numero_derivacoes(Arvore arv){
    if(arv == NULL) return 0;
    if(arv->sae != NULL || arv->sad != NULL) return 1 + numero_derivacoes(arv->sae) + numero_derivacoes(arv->sad);
}

int pontos_ociosos(Arvore arv){
    if(arv == NULL) return 0;
    int n = arv->pdr.trafego < arv->pdr.capacidade/2 ? 1 : 0;
    n += pontos_ociosos(arv->sae);
    n += pontos_ociosos(arv->sad);
    return n; 
}

int arvore_cheia(Arvore arv){
    if(arv != NULL){
        if(arv->sae != NULL && arv->sad == NULL) return 0;
        if(arv->sae == NULL && arv->sad != NULL) return 0;

        int cheia = arvore_cheia(arv->sae);
        if(cheia)
            cheia = arvore_cheia(arv->sad);
        else return 0;

        return cheia;
    }else return 1;
}

int buscar_nivel(Arvore arv, char * nome){
    if(arv == NULL) return -1;
    if(strcmp(arv->pdr.nome, nome) == 0) return 0;
    int nivel =  1 + buscar_nivel(arv->sae, nome);
    if(nivel <= 0)nivel = 1+ buscar_nivel(arv->sad, nome);
    return nivel;
}

PontoDeRede * pdr_menor_trafego(Arvore arv){
    if(arv == NULL) return NULL;
    Arvore aux = arv;
    while(aux->sae != NULL) aux = aux->sae;
    return &(aux->pdr);
}

//@TODO:: Adcionar funções de balanceamento na remoção
int remover_ordenado(Arvore *arv, double traf){
    if(arv == NULL || (*arv) == NULL) return 0;

    double trafego = (*arv)->pdr.trafego;
    int sucesso;

    if(traf > trafego)      sucesso = remover_ordenado(&(*arv)->sad, traf);
    else if(traf < trafego) sucesso = remover_ordenado(&(*arv)->sae, traf);
    else{
        if((*arv)->sae == NULL && (*arv)->sad == NULL){

            free((*arv)->pdr.nome);
            free((*arv)->pdr.localizacao);
            free(*arv);
            *arv = NULL;
            return 1;

        }
        else if((*arv)->sae != NULL && (*arv)->sad == NULL){
            Arvore temp = *arv;
            *arv = temp->sae;
            free(temp);
            return 1;

        }  
        else if((*arv)->sae == NULL && (*arv)->sad != NULL){
            Arvore temp = *arv;
            *arv = temp->sad;
            free(temp);
            return 1;

        }else{
            Arvore aux = (*arv)->sae;
            
            while(aux->sad != NULL) aux = aux->sad;

            PontoDeRede temp = (*arv)->pdr;
            (*arv)->pdr = aux->pdr;
            aux->pdr = temp;

            return remover_ordenado(&(*arv)->sae, traf);
        }
    }
}

Arvore busca_binaria(Arvore arv, double trafego){
    if(arv == NULL) return NULL;

    if(trafego == arv->pdr.trafego) return arv;

    if(trafego > arv->pdr.trafego) busca_binaria(arv->sad, trafego);
    else busca_binaria(arv->sae, trafego);
}

void exibir_arvore(Arvore arv){
    if(arv == NULL) printf("<>");
    else{
        printf("< %s", arv->pdr.nome);
        exibir_arvore(arv->sae);
        exibir_arvore(arv->sad);
        printf(">");
    }
}

void exibir_ordenado(Arvore arv){
    if(arv != NULL){
        exibir_ordenado(arv->sae);
        printf("Identificador: %s\tCapacidade: %lf\tTrafego: %lf\n", arv->pdr.nome, arv->pdr.capacidade, arv->pdr.trafego);
        exibir_ordenado(arv->sad);
    }
}

int arvores_iguais(Arvore arv1, Arvore arv2){
    if(arv1 == NULL && arv2 == NULL) return 1;
    if(arv1 == NULL) return 0;
    if(arv2 == NULL) return 0;
    if(strcmp(arv1->pdr.nome, arv2->pdr.nome) != 0) return 0;
    if(strcmp(arv1->pdr.localizacao, arv2->pdr.localizacao) != 0) return 0;
    if(arv1->pdr.capacidade != arv2->pdr.capacidade) return 0;
    if(arv1->pdr.trafego != arv2->pdr.trafego) return 0;

    int igual = arvores_iguais(arv1->sae, arv2->sae);
    if(igual) igual = arvores_iguais(arv1->sad, arv2->sad);
    return igual;
}

void liberar_arvore(Arvore * arv){
    if(arv != NULL){
        if(*arv != NULL){
            liberar_arvore(&(*arv)->sae);
            liberar_arvore(&(*arv)->sad);
            
            free((*arv)->pdr.nome);
            free((*arv)->pdr.localizacao);
            free(*arv);

            *arv = NULL;
        }
    }
}

int rotacionar_direita(Arvore * arv){
    if( *arv != NULL)
    if ((*arv)->sae != NULL){
        Arvore temp = (*arv)->sae;
        (*arv)->sae = temp->sad;
        temp->sad = *arv;
        (*arv)->fb = 0;
        temp->fb = 0;

        *arv = temp;
        return 1;
    }
    return 0;
}

int rotacionar_esquerda(Arvore * arv){
    if( *arv != NULL)
    if((*arv)->sad != NULL){
        Arvore temp = (*arv)->sad;
        (*arv)->sad = temp->sae;
        temp->sae = *arv;
        (*arv)->fb = 0;
        temp->fb = 0;

        *arv = temp;
        return 1;
    }
    return 0;
}

int rotacionar_dir_esq(Arvore * arv){
    if(*arv != NULL)
    if((*arv)->sae != NULL){
        
        Arvore filho_esq = (*arv)->sae;
        Arvore neto_dir = filho_esq->sad;
        
        filho_esq->sad = neto_dir->sae;
        neto_dir->sae = filho_esq;

        (*arv)->sae = neto_dir->sad;
        neto_dir->sad = *arv;

        if(neto_dir->fb == -1){
            (*arv)->fb = 0;
            filho_esq->fb=  1;

        }else if(neto_dir->fb == 1){
            (*arv)->fb = -1;
            filho_esq->fb = 0;

        }else{
            (*arv)->fb = 0;
            filho_esq->fb = 0;
        }

        neto_dir->fb = 0;
        *arv = neto_dir;
        return 1;
    }

    return 0;
}


int rotacionar_esq_dir(Arvore * arv){
    if(*arv != NULL)
    if((*arv)->sad != NULL){
        
        Arvore filho_dir = (*arv)->sad;
        Arvore neto_esq = filho_dir->sae;
        
        filho_dir->sae = neto_esq->sad;
        neto_esq->sad = filho_dir;

        (*arv)->sad = neto_esq->sae;
        neto_esq->sae = *arv;

        if(neto_esq->fb == -1){
            (*arv)->fb = 1;
            filho_dir->fb=  0;

        }else if(neto_esq->fb == 1){
            (*arv)->fb = 0;
            filho_dir->fb = -1;

        }else{
            (*arv)->fb = 0;
            filho_dir->fb = 0;
        }

        neto_esq->fb = 0;
        *arv = neto_esq;
        return 1;
    }

    return 0;
}

void exibir_pdr(PontoDeRede * pdr){
    printf("Identificador:%s\tCapacidade:%lf\nLocalizacao:%s\tTrafego:%lf\n", 
    pdr->nome, pdr->capacidade, pdr->localizacao, pdr->trafego);
}

void escrever_arquivo(Arvore arv, FILE * f){
    if(arv != NULL) {
        fprintf(f, "%s;%s;%lf;%lf;", arv->pdr.nome, arv->pdr.localizacao, arv->pdr.capacidade, arv->pdr.trafego);
        escrever_arquivo(arv->sae, f);
        escrever_arquivo(arv->sad, f);
    }
}

int ler_arquivo(Arvore * arv, FILE *f){
    if(f == NULL) return 0;
    char text[1000];
    int n;
    double cap, traf;
    char * nome, * loc;

    fread(text, 1, 1000, f);

    nome = strtok(text, ";");
    while(nome != NULL){
        loc = strtok(NULL, ";");
        if(loc == NULL) return 0;
        cap = atoi(strtok(NULL, ";"));
        traf = atoi(strtok(NULL, ";"));
        insere_ordenado(arv, &n, nome, loc, cap, traf);
        nome = strtok(NULL, ";");
    }
    return 1;
}