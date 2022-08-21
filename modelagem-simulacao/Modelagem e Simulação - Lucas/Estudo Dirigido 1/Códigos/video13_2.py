from random import seed
from matplotlib import pyplot as plt
import numpy as np
from scipy.stats import binom
from scipy.special import factorial

seed(100) # semente do gerador de numeros aleatórios

vp = [0.5, .02, 0.05] # probabilidade de sucesso
n = 100 # numero de experimentos
for p in vp:
    Pk = np.zeros(n)
    vk = np.arange(0, n)
    ns = 1000 # numero de simulações

    for j in range(0, ns): #faca para ns simulacoes
        S = 0 # numero de sucessos
        for i in range(0, n): # faça para n experimentos
            r = np.random.uniform()
            if(r<=p): # se o sucesso
                S = S+1
        Pk[S] = Pk[S]+1

    Pk= Pk/sum(Pk) #normaliza a distribuição de probabilidade
    #plt.plot(vk, Pk, 'ro')
    plt.figure(figsize=(10, 6))
    plt.xlim(np.min(vk[Pk>0]), np.max(vk[Pk>0]))
    plt.bar(vk, Pk, label='Simulação')

    #curva teorica
    Pkt = np.zeros(n+1) # valores teoricos da probabilidade
    vkt = np.arange(0, n+1) # variacao em k
    for k in range(0, n+1): # varia de 0 até n
        Pkt[k] = (factorial(n)/(factorial(n-k)*factorial(k)))*(p**k)*(1-p)**(n-k)
    plt.plot(vkt, Pkt, 'r--', label='Prob. Teorica Binomial')

    #curva teorica
    Po = np.zeros(n+1) # valores teoricos da probabilidade
    vo = np.arange(0, n+1) # variacao em k
    lbd = n*p
    for k in range(0, n+1): # varia de 0 até n
        Po[k] = (np.exp(-lbd)*lbd**k)/factorial(k)
    plt.plot(vo, Po, 'k--', label= 'Prob. Teorica Poisson')
    plt.title('p = '+str(p))
    plt.xlabel('k', fontsize= 15)
    plt.ylabel('P(k)', fontsize= 15)
    plt.legend()
    plt.show()


