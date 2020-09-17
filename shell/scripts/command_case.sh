#!/bin/bash
local=lavanderia
local1=banheiro
case $local in
	quarto)
		echo "voce está no quarto";;
	cozinha)
		echo "voce está na cozinha";;
	sala)
		echo "voce está na sala";;
	banheiro | lavanderia)
		echo "voce está no banheiro";;
	*)
		echo "Você não está dentro de casa";;
esac
