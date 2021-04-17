#include<stdio.h>
#include <string.h>
void wordreverse(char s[]);
int main()
{
    printf("Digite uma frase: ");
	char s[500];
	scanf("%[^\n]s",&s);
	wordreverse(s);
	return 0;
}
void wordreverse(char s[])
{
    int i,j;
    for(i=strlen(s);i>-1;i--)
    {
        if((s[i]!=' ')&&(s[i-1]==' ')||i==0)
        {
            for(j=i;j<strlen(s);j++)
            {
                printf("%c",s[j]);
                if(s[j]==' ') break;
            }
            printf(" ");
        }
    }
}
