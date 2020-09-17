#!/bin/bash
arquivo=/etc/passwd
if [ -f $arquivo ]
then
	if [ -r $arquivo ] #se o arquivo existe ele vai testar se há pouco lê-lo
	then
		tail -5 $arquivo #exibe 5 ultimas linhas do arquivo
	else
		echo "Sem permissao para ler o arquivo"
	fi
else 
	echo "Arquivo nao encontrado"
fi
