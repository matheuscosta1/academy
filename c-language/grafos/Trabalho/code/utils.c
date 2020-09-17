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

double distancia(float lat1, float lng1, float lat2, float lng2)
{
    double dx, dy, dz;
    double rad =3.1415926536 / 180;
    lng1 -= lng2;
    lng1 *= rad, lat1 *= rad, lat2 *= rad;
 
    dz = sin(lat1) - sin(lat2);
    dx = cos(lng1) * cos(lat1) - cos(lat2);
    dy = sin(lng1) * cos(lat1);
    return asin(sqrt(dx * dx + dy * dy + dz * dz) / 2) * 2 * 6371;
}