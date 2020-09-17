#!/bin/bash
# Copiar a listagem de um diretório para arquivos úncicos de acordo com a data e hora
arq=`date +%d%m%y%H%M` 
#variavel que diferencia um arquivo de outro Day,Month,Year,Hour,Minute
ls -la /home/matheus.costa > log.$arq #redirecionamento de comandos 
#toda vez que eu rodar o script a variavel arq tera um script diferente lá dentro(a listagem). Se eu não pegasse esse valor de data e horário do instante momento eu estaria criando uma listagem gigantesca nas diversas vezes da executação do meu programa
