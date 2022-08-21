from math import e
from time import sleep
import numpy as np
from tabulate import tabulate
from DeterministicSimulation import DeterministicSimulation
from Random_Simulation import Random_Simulation



def menu():
    print("\nChoose an option: ")
    print("1: Deterministc Simulation:")
    print("2: Random Simulation")
    return

def sub_menu():
    print("\nChoose an option: ")
    print("1: With queue")
    print("2: Without queue")
    return



if  __name__ == "__main__":
    
    menu()
    option = int(input())
    sub_menu()
    option2 = int(input())

    if(option == 1):
        S = DeterministicSimulation(option2)
        print(tabulate(S.data,headers = ["Evento", "Cliente", "Tempo no relógio", "Estado do servidor", "Tamanho da fila", "Horário de chegada", "Horário de saída"], tablefmt="presto"))
    else:
        S = Random_Simulation(option2)
        print(tabulate(S.data,headers = ["Evento", "Cliente", "Tempo no relógio", "Estado do servidor", "Tamanho da fila", "Horário de chegada", "Horário de saída"], tablefmt="presto"))
    
    S.calculateStatistics()



    