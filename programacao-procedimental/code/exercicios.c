#include <stdio.h>
#include <stdlib.h>
#define ZERO 0

int is_even(int number){
    return number%2==ZERO;
}

int is_odd(int number){
    return !(number%2==ZERO);
}

void first_odd_natural_numbers(int number){
    
    for(int i=ZERO; i <= number; i++){
        if (!(i % 2 == ZERO)){
            printf("%d\n", i);
        }
        else continue;
    }

}

void first_fifty_even_numbers(){

    for(int i=ZERO; i < 50; i++){
        if (i % 2 == ZERO){
            printf("%d\t", i);
        }
        else continue;
    }

}

void ascendent_order(int number){

    for(int i=ZERO; i <= number; i++){
        printf("%d\t", i);
    }

}

void descendent_order(int number){

    for(int i=number; 0 <= i; i--){
        printf("%d\t", i);
    }

}

void ascendent_order_odd_numbers(int number){

    for(int i=ZERO; i <= number; i++){
        if (is_odd(i)){
            printf("%d\t", i);
        }
    }

}

void descendent_order_odd_numbers(int number){

    for(int i=number; ZERO <= i; i--){
        if (is_odd(i)){
            printf("%d\t", i);
        }
    }

}

void ascendent_order_even_numbers(int number){

    for(int i=ZERO; i <= number; i++){
        if (is_even(i)){
            printf("%d\t", i);
        }
    }

}

void descendent_order_even_numbers(int number){

    for(int i=number; ZERO <= i; i--){
        if (is_even(i)){
            printf("%d\t", i);
        }
    }

}

int sum_n_odd_numbers(int number){
    int sum = 0;
    for(int i=ZERO; i <= number; i++){
        if (is_odd(i)){
            sum += i;
        }
        else continue;
    }
    return sum;
}

int sum_n_even_numbers(int number){
    int sum = 0;
    for(int i=ZERO; i <= number; i++){
        if (is_even(i)){
            sum += i;
        }
        else continue;
    }
    return sum;
}

int sum_n_natural_numbers(int number){
    int sum = 0;
    for(int i=ZERO; i <= number; i++){
        sum += i;
    }
    return sum;
}

void get_first_thousand_even_numbers(int iterations){
    int entrypoint;
    for(int i=ZERO; i <= iterations; i++){
        scanf("%d", &entrypoint);
        if(is_even(entrypoint)){
            printf("%d é par\n", entrypoint);
        }
        else continue;
    }
}

void number_dividers(int number){ 
    for(int i = 1; i <= number; i++){
        if(number % i == 0){
            printf("%d é divisor do número %d\n", i, number);
        }
        else continue;
    }
}

int is_multiple_three(int number){
    return number % 3 == 0;
}

int is_multiple_five(int number){
    return number % 5 == 0;
}

int sum_first_thousand_numbers_multiple_three_or_five(int iterator){
    int sum = 0;
    for(int i=ZERO; i <= iterator; i++){
        if(is_multiple_three(i) || is_multiple_five(i)){
            sum += i;
        }
        else continue;
    }
    return sum;
}

int *odd_numbers_generate(int quantity){
    int *array = (int*) malloc(quantity * sizeof(int));

    if (array == NULL) { 
        printf("Memory not allocated.\n"); 
        exit(0);
    }
    for(int i = 1; i <= quantity; i=i+2){
        if(is_odd(i)){
            array[i] = i;
        }
        else continue;
    }
    return array;
}

void print_array(int *array, int quantity){
    for(int i = 1; i <= quantity; i=i+2){
        printf("%d\t", array[i]); 
    }

}

int **generate_matriz(int size){
    int **matriz = (int *) malloc(size * sizeof(int *));

    if(matriz == NULL){
        printf("Linhas não foram alocadas com sucesso");
    }

    for(int i = 0; i < size; i++){
        matriz[i] = (int *) malloc(size * sizeof(int *));
        if(matriz[i] == NULL){
            printf("Colunas não foram alocadas com sucesso");
            break;
        }

        for(int j = 0; j < size; j++){
           matriz[i][j] = 0;
        }
    }
    return matriz;
}

void print_matriz(int **matriz, int size){
    for(int i = 0; i < size; i++){
        for(int j = 0; j < size; j++){
           printf("%d\t", matriz[i][j]);
        }
        printf("\n");
    }
}

int fatorial(int number){
    if(number == 0) return 1;
    else return number * fatorial(number-1);
}

int fibonacci(int number){
    if (number == 0 || number == 1) return number;
    else return fibonacci(number - 1) + fibonacci(number - 2);
}


int fibonacci2(int n){
    int i = 1;
    int j = 0;
    int t;
    for(int k = 1; k <= n; k++){
        t = i + j;
        i = j;
        j = t;
    }
    return j;
}

void troca_valores(int *number1, int *number2){
    int aux = *number1;
    *number1 = *number2;
    *number2 = aux;
}

void maior_menor_valor(int *number1, int *number2){
    int maior, menor;
    if(number1 > number2){
        maior = *number1;
        menor = *number2;
    }
    else{
        maior = *number2;
        menor = *number1;
    }
    printf("Maior valor: %d Menor valor: %d", maior, menor);
}


struct aluno{
    char nome[50];
    int data_nascimento;
    int matricula;
};
typedef struct aluno Aluno;


int main(){
    int size = 5;
    //Aluno *vetor = (Aluno *) malloc(size*sizeof(Aluno));
    
    printf("%d", fibonacci(5));
    printf("%d", fibonacci2(5));

    

    /**for(int i=0; i < size; i++){
        printf("Entre com o nome do aluno %d", i);
        scanf("%s", vetor[i].nome);
        printf("%s",vetor[i].nome );
    }**/
    return 0;
}
