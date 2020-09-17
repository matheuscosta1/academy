#!/bin/bash

echo "Escolha uma opção:"
echo "1- Arquivos temporários "
echo "2- Arquivos Shell Script"
echo "3- Arquivos Python"
read text
cd /home/matheus.jose/Git/Backup/Python
if [ $text = 1 ]
then
	echo -e "\nArquivos temporários"
	echo -e "\nOpcao 1\n"
	ls *.tmp
elif [ $text = 2 ]
then
	echo -e "\nOpcao 2\n"
	echo -e "\nArquivos Shell Script"	
	ls *.sh
elif [ $text = 3 ]
then
	echo -e "\nArquivos Python"
	echo -e "\nOpcao 3\n"
	ls *.py
else
	echo -e "Opcao invalida"
fi
echo -e "\n"
