#include <stdio.h>

void reverse(char [], int);

void reverse(char str[], int size){
    printf("%c", str[size -1]);
    if(size > 0)reverse(str, size -1);
}

int main(int argc, char const *argv[]) {
  reverse("Sou feliz", 9);
  return 0;
}
