import numpy as np
import matplotlib.pyplot as plt

lbd = 5 # Taxa
n=1000 # numero de pontos entraidos de uma distribuicao de Poisson
p = np.random.poisson(lbd, n)
k = np.arange(0, np.max(p))
count, bins, ignored = plt.hist(p, bins=k, density=True, color= "#0504aa", alpha=0.7, rwidth=0.9)
plt.xlabel('k', fontsize= 15)
plt.ylabel('P(k)', fontsize= 15)
plt.show()