#include <bits/stdc++.h>

using namespace std;

int main(){
    int soma = 0;
    int numero;

    cout << "Entre com um numero para repeticoes: ";
    cin >> numero;

    int vetor[numero];
    
    for(int i = 0; i < numero; i++){
        cin >> vetor[i];
        soma = soma + vetor[i];
        cout << soma << endl;
    }
    
    cout << soma << endl;

}