#include <stdio.h>

void printMedia(float *, int);
void printNotas(float **, int, int);
int main(){
float **alunos, *medias;
float maior = 0;
int total, i, j;
printf("Digite a quantidade de alunos:");
scanf("%d", &total);
alunos = (float **) malloc(sizeof(float)*total);
medias = (float *) malloc(sizeof(float)*total);
for(i =0; i < total; i++){
    alunos[i] = (float *) malloc(sizeof(float)*3);
}
for(i = 0; i< total; i++){
    printf("Notas do aluno %d:\n", i+1);
    medias[i]= 0;
    for(j =0; j<3; j++){
        printf("Nota %d: ", j+1);
        scanf("%f", &alunos[i][j]);
        medias[i] +=alunos[i][j];
        if(j ==2)if(maior < alunos[i][j]) maior = alunos[i][j];
    }
    medias[i] = medias[i]/3;
}

printMedia(medias, total);

maior = 10/maior;
for(i = 0; i< total; i++){
    alunos[i][2] = alunos[i][2]*maior;
}

printNotas(alunos, total, 3);
return 0;
}
void printNotas(float** notas, int lin, int cols){
    int i, j;
    float soma;
    printf("\nNotas finais\n");
    printf("Aluno\tA1\tA2\tA3\tTotal\n");
    for(i=0; i< lin; i++){
        printf("%d\t", i+1);
        soma =0;
        for(j =0; j< cols; j++){
            soma += notas[i][j];
            printf("%0.2f\t", notas[i][j]);
        }
        printf("%0.2f\n",soma);
    }

}
void printMedia(float * vetor, int tam){
    int i;
    printf("\nMedias\n");
    for(i =0; i < tam; i++){
        printf("Aluno %d: %0.2f\n", i+1, *(vetor+i));
    }
}
