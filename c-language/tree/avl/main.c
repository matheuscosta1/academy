#include "avl.h"
#include "utils.h"

void showMenu(int *);

int adcionar_pdr(Arvore *);
void menor_trafego(Arvore);  
void rede_ociosas(Arvore);  
void nos_derivacao(Arvore);  
void estado_arvore(Arvore);  
void exibir_nivel(Arvore);  
void exibe_arvore(Arvore, int);
void exportar_txt(Arvore );
void comparar_arvores(Arvore);
void limpar_arvore(Arvore *);

int main(int argc, char const *argv[]){

    Arvore arv = criar_arvore();
    int n, op;

    /** Nos exemplos**/

    insere_ordenado(&arv, &n, "6", "167S,156O", 150, 6);
    insere_ordenado(&arv, &n, "12", "167S,156O", 150, 12);

    insere_ordenado(&arv, &n, "16", "167S,156O", 150, 76);
    insere_ordenado(&arv, &n, "11", "167S,156O", 150, 11);

    insere_ordenado(&arv, &n, "14", "167S,156O", 150, 14);
    insere_ordenado(&arv, &n, "8", "167S,156O", 150, 8);

    insere_ordenado(&arv, &n, "3", "167S,156O", 150, 3);

    do{
        showMenu(&op);
        switch(op){
            case 1: adcionar_pdr(&arv); break;
            case 2: menor_trafego(arv); break;
            case 3: rede_ociosas(arv); break;
            case 4: nos_derivacao(arv); break;
            case 5: estado_arvore(arv); break;
            case 6: exibir_nivel(arv); break;
            case 7: exibe_arvore(arv, 0); break;
            case 8: exibe_arvore(arv, 1); break;
            case 9: exportar_txt(arv); break;
            case 10: comparar_arvores(arv); break;
            case 11: limpar_arvore(&arv); break;
        }
        if(op!= 12){
            printf("Pressione qualquer tecla para continuar...");
            setbuf(stdin, NULL);
            getchar();
        }
    }while(op != 12);

    return 0;
}

void showMenu(int *op){
    printInBlock("Menu", 0);
    printInBlockN( 1, "Adcionar ponto de rede", 0);
    printInBlockN( 2, "Exibir ponto de rede de menor trafego", 0);
    printInBlockN( 3, "Exibir quantidade de pontos de rede ociosos", 0);
    printInBlockN( 4, "Exibir quantidade de nos de derivacao", 0);
    printInBlockN( 5, "Exibr estado da arvore", 0);
    printInBlockN( 6, "Buscar nivel do ponto de rede", 0);
    printInBlockN( 7, "Exibir arvore", 0);
    printInBlockN( 8, "Exibir arvore ordenada", 0);
    printInBlockN( 9, "Exportar arvore para txt", 0);
    printInBlockN(10, "Comparar arvores", 0);
    printInBlockN(11, "Limpar arvore", 0);
    printInBlockN(12, "Sair", 1);
    
    printf("Digite a opção desejada: ");
    setbuf(stdin, NULL);
    scanf("%d", op);
    setbuf(stdin, NULL);
    printf("\n");
}

int adcionar_pdr(Arvore *arv){
    char nome[30], loc[30];
    double traf,cap;
    int n;
    printInBlock("1. Adcionar ponto de rede", 1);
    
    printf("Identificador: ");
    scanf("%[^\n]s", nome);
    setbuf(stdin, NULL);

    printf("Localizacao: ");
    scanf("%[^\n]s", loc);
    setbuf(stdin, NULL);

    printf("Capacidade(MB/s): ");
    scanf("%lf", &cap);
    
    printf("Trafego(MB/s): ");
    scanf("%lf", &traf);

    n = insere_ordenado(arv, &n, nome, loc, cap, traf);
    if(n) printf("Ponto de rede criado com sucesso.\n");
    else printf("Erro ao criar o ponto de acesso\n");
}

void menor_trafego(Arvore arv) {
    printInBlock("2. Ponto de Menor Trafego", 1);
    PontoDeRede * pdr = pdr_menor_trafego(arv);
    if(pdr != NULL) exibir_pdr(pdr);
    else printf("A arvore esta vazia\n");
}  

void rede_ociosas(Arvore arv) {
    printInBlock("3. Pontos Ociosos", 1);
    printf("Existem %d pontos de rede ociosos\n", pontos_ociosos(arv));
}

void nos_derivacao(Arvore arv) {
    printInBlock("4. Nos de derivacao", 1);
    printf("Existem %d nos de derivacao na arvore\n", numero_derivacoes(arv));

}  

void estado_arvore(Arvore arv) {
    printInBlock("5. Estado da Arvore", 1);
    printf("A arvore %s.\n",  (arvore_cheia(arv) == 1) ?"esta cheia" : "nao esta cheia");
}  

void exibir_nivel(Arvore arv) {
    printInBlock("6. Buscar nivel do Ponto de Rede", 1);
    char nome[30];

    printf("Digite o identificador do ponto de rede: ");
    setbuf(stdin, NULL);
    scanf("%[^\n]s", nome);
    int nivel = buscar_nivel(arv, nome);
    if(nivel < 0) printf("O ponto de rede nao existe\n");
    else printf("Nivel do no: %d\n", nivel);
}  

void exibe_arvore(Arvore arv, int ordenada){
    printInBlock(ordenada ? "8. Exibir Arvore Ordenada" : "7. Exibir Arvore", 1);
    if(ordenada) exibir_ordenado(arv);
    else exibir_arvore(arv);
    printf("\n");
}

void exportar_txt(Arvore arv){
    printInBlock("9. Exportar Arvore", 1);
    char nome[30];
    
    printf("Digite o nome do arquivo: ");
    scanf("%[^\n]s", nome);
    FILE * f;
    if( (f = fopen(nome, "wb")) != NULL){
        escrever_arquivo(arv, f);
        fclose(f);

        printf("Arvore exportada com sucesso\n");
    }else printf("Não foi possivel criar o arquivo.\n");

}

void comparar_arvores(Arvore arv){
    printInBlock("9. Comparar Arvores", 1);
    char nome[30];
    Arvore  temp = NULL;
    printf("Digite o nome do arquivo da arvore a comparar: ");
    scanf("%[^\n]s", nome);
    FILE * f;
    if( (f = fopen(nome, "r")) != NULL){
        ler_arquivo(&temp, f);
        fclose(f);
        int iguais = arvores_iguais(arv, temp);
        printf("As arvores %s\n", iguais? "sao iguais" : "nao sao iguais");

        liberar_arvore(&temp);

    }else printf("Não foi possivel acessar o arquivo.\n");

}

void limpar_arvore(Arvore * arv){
    liberar_arvore(arv);
    printf("A arvore foi limpa com sucesso\n");
}