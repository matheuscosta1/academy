#include <stdio.h>

void substring(char *, int, int);
void substrings(char *, int, int);
void print(char *,int, int);


void main(int argc, char ** argv){
	char palavra []= "STFU";
	substrings(palavra, 0, sizeof(palavra));
}

void substrings(char * word,int i, int tam){
	substring(&word[i], 0, tam-i);
	if( i < tam){
		i++;
		substrings(word, i, tam);
	}
}

void substring(char *word, int i, int tam){
	if(i < tam){
		if(word[i] != '\0')print(word, 0, i+1);
		i++;
		substring(word, i,tam);
	}else printf("\n");
}

void print(char * sub,int i, int tam){
	if(i < tam){
		printf("%c", sub[i]);
		i++;
		print(sub, i, tam);
	}else printf(" :: ");
}