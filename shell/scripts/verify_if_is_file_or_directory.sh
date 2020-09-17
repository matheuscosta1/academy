#!/bin/bash

if [ -e $HOME ] #objeto existe ou nao
then
	echo "O objeto existe. Vamos ver se é arquivo ou diretório"
	if [ -f $HOME ] #file
	then
		echo "É um arquivo"
	else
		echo "É um diretório"
	fi
else
	echo "Objeto não encontrado"
fi


