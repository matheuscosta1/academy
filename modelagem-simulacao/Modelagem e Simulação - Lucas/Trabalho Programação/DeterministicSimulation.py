import numpy as np
import time
import tabulate

class DeterministicSimulation():
    NClients = 0
    TEC = 0
    TS = 0
    time = 0
    TR=0
    ES=0
    TF=0
    HC=0
    HS=9999

    arrive = []
    TF_list = []
    ES_list = []
    TR_list = []
    TM_list = []
    HS_list = []
    data = []

    def menu(self):
        self.TEC = int(input('Digite o valor para TEC: '))
        self.TS = int(input('Digite o valor para TS: '))
        self.time = int(input('Digite o tempo de execução: '))

    def processArrival(self, TEC, TS):
        self.TR=self.HC
        if self.ES==0 :
            self.ES=1
            self.HS=self.TR + TS
        
        else:
            self.TF = self.TF+1
        
        self.HC = self.TR + TEC

    
    def processArrivalLimit(self, TEC, TS, limit):
        self.TR=self.HC
        if self.ES==0:
            self.ES=1
            self.HS=self.TR + TS
  
        else:
            if(self.TF < limit):
                self.TF = self.TF+1
        
        self.HC = self.TR + TEC

    def processExit(self, TS):
        self.TR = self.HS
        if self.TF>0:
            self.TF=self.TF-1
            self.HS = self.TR + TS
        else:
            self.ES=0
            self.HS = 9999



    def updateStatistics(self, status, client):
        self.data.append([status, client, self.TR, self.ES, self.TF, self.HC, self.HS])
        self.TF_list.append(self.TF)
        self.ES_list.append(self.ES)
        self.TR_list.append(self.TR)
        self.HS_list.append(self.HS - self.TR)
        
        if status == "Chegada":
            self.arrive.append([status, client, self.TR, self.ES, self.TF, self.HC, self.HS])

        if self.TF > 0:
            self.TM_list.append(self.HS - self.TR)
        return
    
    def process_with_queue_limit(self):
        QClient = []
        client =0
        self.menu()
        limit = int(input("Digite o tamanho da fila: "))
        
        while self.time>self.TR:
            
            if self.HC < self.HS:
                self.processArrivalLimit(self.TEC, self.TS, limit)
                status = "Chegada"
                client += 1
                self.NClients +=1
                QClient.append(client)
                self.updateStatistics(status, client)
                
            else:
                self.processExit(self.TS)
                c = QClient.pop()
                status = "Saída"
                self.updateStatistics(status, c)

    
    def process_without_queue_limit(self):
        QClient = []
        client =0
        self.menu()
        
        while self.time>self.TR:
            
            if self.HC < self.HS:
                self.processArrival(self.TEC, self.TS)
                status = "Chegada"
                client += 1
                self.NClients +=1
                QClient.append(client)
                self.updateStatistics(status, client)
                
            else:
                self.processExit(self.TS)
                c = QClient.pop()
                status = "Saída"
                self.updateStatistics(status, c)
    
    def calculateStatistics(self):
        print("Número medio de entidades na fila: ", sum(self.TF_list)/len(self.TF_list))
        print("Taxa medio de ocupação do servidor: ", sum(self.ES_list)/len(self.data))
        print("Tempo medio de uma entidade na fila: ", sum(self.TM_list)/len(self.arrive))
        print("Tempo medio no sistema: ", self.TR_list[-1]/len(self.arrive))
        
        
 

    def __init__(self, option2):
        self.option2 = option2

        if(option2 == 1):
            self.process_with_queue_limit()
        elif(option2 == 2):
            self.process_without_queue_limit()
    


        

    