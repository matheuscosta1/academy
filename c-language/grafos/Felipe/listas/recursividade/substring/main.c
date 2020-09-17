#include <stdio.h>
#include <stdlib.h>
void substring(char *str,int n,int i);

int main()
{
    substring("felipe",6,0);
    return 0;
}



void substring(char* str,int n,int i)
{  int j,f;

  if(i==n)
 return;

for(f=i;f<n;f++)
{
for(j=i;j<=f;j++)
{
    printf("%c",str[j]);

}
printf(" ");

}

 substring(str,n,i+1);


}


