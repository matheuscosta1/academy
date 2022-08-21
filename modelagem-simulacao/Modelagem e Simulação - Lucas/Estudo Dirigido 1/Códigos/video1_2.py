import numpy as np
import matplotlib.pyplot as plt

p=0.6 # chance de sair cara
vp = [] # lista de armazena a frequencia de ocorrencias
vsim = [] #armazena o numero de simulações
Nmax = 1000 # numero máimo de simulações

for nsim in np.arange(1, Nmax, 10): #simula de 1 até Nmax
    nhead = 0 # numero de caras
    for i in range(1, nsim):  #o numero de simulações aumenta
        if np.random.uniform()<p:
            nhead = nhead+1
    vp.append(nhead/nsim)
    vsim.append(nsim)

#Mostra os resultados em uma figura

plt.figure(figsize=(8,6))
plt.plot(vsim, vp, linestyle='-', color="blue", linewidth=2, label='Valor simulado')
plt.axhline(y=p, color='r', linestyle='--', label = 'Valor teorico')
plt.ylabel("Fracao de caras", fontsize=20)
plt.xlabel("Numero de experimentos", fontsize=20)
plt.xlim([0.0, Nmax])
plt.ylim([0.0, 1.0])
plt.legend()
plt.show()