#ifndef REGISTRO_H_INCLUDED
#define REGISTRO_H_INCLUDED

typedef struct Reg* Registro;

Registro Cria_Registro(int idade,char* nome,char* curso);
void Libera_Registro(Registro* g);
Registro Maior_Registro(Registro a,Registro b);
Registro Menor_Registro(Registro a,Registro b);
char* get_nome(Registro a);
int get_idade(Registro a);
int get_chave(Registro a);
void imprime(Registro a);
char* get_curso(Registro a);

#endif // REGISTRO_H_INCLUDED
