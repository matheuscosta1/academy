import numpy as np

p=0.6 # probabilidade de sair cara
nsim = 10 # num de experimentos
nhead = 0 # num de caras obtidas
saida = [] # armazena as saidas (cara:1, coroa:0)

for i in range(0, nsim):
    if(np.random.uniform() <p): # se menor que p, cara
        nhead = nhead+1 # incrementa o contador de caras
        saida.append(1)
    else:
        saida.append(0)

print("Saida: ", saida)
print("Frenquencia de caras: ", nhead/nsim)

