#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct horario {
    int ano, mes, dia, hora, min; //20 bytes
};
typedef struct horario horario;

struct veiculos {
    char placa[8], modelo[10], cor[10], status; //28 bytes
    horario entrada, saida; // 20 bytes
};
typedef struct veiculos cadVeiculo;

void incluir (FILE *f) {
    cadVeiculo novoVeiculo;

    //cadastrando os dados do veículo
    printf("\n");
    printf("Digite a placa: "); scanf("%s", &novoVeiculo.placa); setbuf(stdin,NULL);
    printf("Digite o modelo: "); gets(novoVeiculo.modelo); setbuf(stdin,NULL);
    printf("Digite a cor: "); gets(novoVeiculo.cor); setbuf(stdin,NULL);
    printf("Digite o status do veículo: "); scanf("%c", &novoVeiculo.status); setbuf(stdin,NULL);
    //if((novoVeiculo.status != P) && (novoVeiculo.status != R))
    //    printf("Status não reconhecido.");

    //cadastrando horário de entrada
    printf("Agora digite o horário de entrada do veículo.\n");
    printf("Hora: "); scanf("%d", &novoVeiculo.entrada.hora); setbuf(stdin,NULL);
    printf("Minuto: "); scanf("%d", &novoVeiculo.entrada.min); setbuf(stdin,NULL);
    printf("Dia: "); scanf("%d", &novoVeiculo.entrada.dia); setbuf(stdin,NULL);
    printf("Mês: "); scanf("%d", &novoVeiculo.entrada.mes); setbuf(stdin,NULL);
    printf("Ano: "); scanf("%d", &novoVeiculo.entrada.ano); setbuf(stdin,NULL);

    //cadastrando horário de saída
    printf("Por fim, digite o horário de saída do veículo.\n");
    printf("Hora: "); scanf("%d", &novoVeiculo.saida.hora); setbuf(stdin,NULL);
    printf("Minuto: "); scanf("%d", &novoVeiculo.saida.min); setbuf(stdin,NULL);
    printf("Dia: "); scanf("%d", &novoVeiculo.saida.dia); setbuf(stdin,NULL);
    printf("Mês: "); scanf("%d", &novoVeiculo.saida.mes); setbuf(stdin,NULL);
    printf("Ano: "); scanf("%d", &novoVeiculo.saida.ano); setbuf(stdin,NULL);

    fwrite (&novoVeiculo, sizeof(cadVeiculo), 1, f);

}
void alterar (FILE *f) {
    
}
void buscar (FILE *f) {
    char placaBuscada[8];
    printf("Placa a ser buscada: ");
    scanf("%s", placaBuscada);
    printf("\n");

    cadVeiculo registro;

    rewind(f);
    while (fread(&registro, sizeof(cadVeiculo), 1, f) > 0)
    {
        if (strcmp(registro.placa, placaBuscada) == 0 && registro.status == 'P')
        {
            printf("Placa: %s", registro.placa); printf("\nModelo: %s", registro.modelo); printf("\nCor: %s", registro.cor);
        }
    }
}

void listar (FILE *f) {
    cadVeiculo cad1; //será o buffer

    while(fread(&cad1, sizeof(cadVeiculo), 1, f)){
        printf("\n");
        printf("Placa: %s", cad1.placa); printf("\nModelo: %s", cad1.modelo); printf("\nCor: %s", cad1.cor);
        printf("\nHorário entrada: %d:%d  %d/%d/%d", cad1.entrada.hora, cad1.entrada.min, cad1.entrada.dia, cad1.entrada.mes, cad1.entrada.ano);
        printf("\nHorário saída: %d:%d  %d/%d/%d", cad1.saida.hora, cad1.saida.min, cad1.saida.dia, cad1.saida.mes, cad1.saida.ano);
        printf("\nStatus: %c", cad1.status);
        printf("\n\n");

    }
}
void remover (FILE *f) {
    char placa[8];
    printf("Placa a ser removida: ");
    scanf("%s", placa);
    printf("\n");

    cadVeiculo veiculo;

    int cont = 1;
    rewind(f);
    while (fread(&veiculo, sizeof(veiculo), 1, f) > 0)
    {
        if (strcmp(veiculo.placa, placa) == 0 && veiculo.status == 'P')
        {
            printf("Registro %d: \n", cont);

            printf("Placa: %s", veiculo.placa); printf("\nModelo: %s", veiculo.modelo); printf("\nCor: %s", veiculo.cor);

            printf("Deseja apagar registro? (1 - Sim, 2 - Nao):");
            int decisao;
            scanf("%d", &decisao);

            if (decisao == 1)
            {
                fseek(f, -sizeof(cadVeiculo), SEEK_CUR);
                veiculo.status = 'R';
                fwrite(&veiculo, sizeof(cadVeiculo), 1, f);
            }

            cont++;
        }
    }

}
int main(){
    FILE *f = fopen ("cadastro.txt", "rb+"); //abrindo o arquivo
    if(f == NULL)
        f = fopen ("cadastro.txt", "wb+");
    if(f == NULL)
        printf("Erro ao abrir o arquivo.");

    int opcao = -1;
    while (opcao != 0) { //menu que vai aparecer na tela
        printf("\n\nBem vindo(a) ao registro de automóveis! Essas são suas opções: \n1- Incluir\n2- Alterar\n3- Remover\n4- Buscar\n5- Listar\n");
        printf("\nDigite a opção escolhida ou 0 para sair: "); scanf(" %d",&opcao);
        switch(opcao) {
            case 1: incluir(f); break;
            case 2: rewind(f); alterar(f); break; //rewind para voltar ao início do arquivo
            case 3: rewind(f); remover(f); break;
            case 4: rewind(f); buscar(f); break;
            case 5: rewind(f); listar(f); break;
            printf("\n\n\n");
        }
    }

    fclose(f); //fechando o arquivo
    return 0;
}