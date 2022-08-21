int main()
{
    int vetor[10], i, j;

    for(i=0; i<10; i++) {
        printf("Coloque um valor para vetor[%d]= ", i); scanf("%d", &vetor[i]);
        
        for(j=0; j < i; j++){
            if(vetor[i] == vetor[j]){
                printf("\nNumero repetido, entre com outro.\n");
                i--;      
            }
        }  
    }
    return 0;
}
 