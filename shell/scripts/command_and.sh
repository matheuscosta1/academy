#!/bin/bash
if [ $USER=matheus.jose ] && [ -w $HOME/.bashrc ]
then
	echo "o usuario $USER tem permissao para alterar o arquivo"
else 
	echo "o usuario $USER nao pode alterar o arquivo agora"
fi
