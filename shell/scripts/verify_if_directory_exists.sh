#!/bin/bash
if [ -d $HOME ]
then
	echo "Seu diretorio home existe e o conteudo é: "
	cd $HOME
	ls -l
else
	echo "Diretório não encontrado"
fi


