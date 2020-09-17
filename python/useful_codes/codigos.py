# num = list()
# pares = list()
# impares = list()
# i = 0
# while i < 5:
#     num.append(int(input("Digite um numero:")))
#     i = i+1
# print(num)

# for i, n in enumerate(num):
#     if n % 2 == 0:
#         pares.append(n)
#     else:
#         impares.append(n)
# print(pares)
# print(impares)

# expressao = str(input("Digite uma expressao: "))
# pilha=[]
# for simbolo in expressao:
#     if simbolo == '(':
#         pilha.append('(')
#     elif simbolo == ')':
#         if len(pilha)>0:
#             pilha.pop()
#         else:
#             pilha.append(')')
# if len(pilha)==0:
#     print('Sua expressao esta valida')
# else:
#     print('Sua expressao esta invalida')

# for index, item in enumerate(['one', 'two', 'three', 'four']):
#     print(index, '::', item)

#py 2.x
# x = map(lambda e : e.upper(), ['one', 'two', 'three', 'four'])
# print(x)

# for i in range(2):
#     print(i)
#     if i == 1:
#         break
# else:
#     print('done')
#lst = ['alpha', 'bravo', 'charlie', 'delta', 'echo']
#for s in lst:
#    print s[:1]
#
#for idx, s in enumerate(lst):
#    print("%s has an index of %d" % (s, idx))

d = {'a': 1, 'b': 2, 'c':3}
for key, value in d.items():
    print(key, value)

print([key for key in d])

e = {'caraio': 1, 'caraiozinho':3, 'porra':2}

for key, value in e.items():
    print(key, value)

print([key for key in e])

from collections import ChainMap

fish = {'name': "Nemo", 'hands': "fins", 'special': "gills"}
dog = {'name': "Clifford", 'hands': "paws", 'color': "red"}

b = dict(ChainMap(fish, dog))

print(b)

lst=[[1,2,3],[4,5,6],[7,8,9]]
print(lst[0][1])

from array import *

my_array = array('i', [1,2,3,4,5])
c = my_array.tolist()
print(c)

my_char_array = array('c', ['g','e','e','k'])
my_char_array.fromstring("stuff")
print(my_char_array)

# my_array = array('c', ['p','o', 'r', 'r', 'a'])
# my_array.fromstring("caraio")
# print(my_array)