#include "utils.h"

void printInBlock(char *text, int b_line){
    int i=0, j = 0;
    
    while(i++ < LINE+2)printf("-");
    printf("\n|");
    
    i = 0;
    if(strlen(text)%2 != 0) j = -1;
    
    while(i++ < j + LINE/2 - strlen(text)/2)printf(" ");
    printf("%s", text);
    i=0;
    while(i++ < LINE/2 - strlen(text)/2)printf(" ");
    printf("|\n");
    i = 0;

    if(b_line){
        while(i++ < LINE + 2)printf("-");
        printf("\n");
    }
}


void printInBlockN(int n,char *text, int b_line){
    int i=0, j = 0;
    
    while(i++ < LINE+2)printf("-");
    printf("\n|");
        
    printf(" %02d | %s", n, text);
    i=0;
    while(i++ < LINE - strlen(text) - 6)printf(" ");
    printf("|\n");
    i = 0;

    if(b_line){
        while(i++ < LINE + 2)printf("-");
        printf("\n");
    }
}
