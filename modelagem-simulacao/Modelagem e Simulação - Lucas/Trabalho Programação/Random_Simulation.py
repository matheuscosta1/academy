import random
import time
import tabulate
import math

class Random_Simulation():
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
        self.time = int(input('Digite o tempo de execução: '))
        self.TEC = self.TECGenerate()
        self.TS = self.TSGenerate()
        

    def TECGenerate(self):
        options = []
        TEC = 0
        aux = 0
        for i in range(0,100):
            aux = random.uniform(0,1)
            options.append(aux)

        k = 1 + 3.3*math.log10(100) #7.6 aprox 8
        h = max(options)*100/ k

        value = random.choice(options)*100
        if value >= 0.0 and value <= h: #Classe0_8
            TEC = (0 + h)/2
            print("O valor de TEC é: ",int(TEC))
            return int(TEC)
        elif value >= h and value < 2*h: #Classe8_16
            TEC = (h + 2*h)/2
            print("O valor de TEC é: ",int(TEC))
            return int(TEC)
        elif value >= 2*h and value < 3*h: #Classe16_24
            TEC = (2*h + 3*h)/2
            print("O valor de TEC é: ",int(TEC))
            return int(TEC)
        elif value >= 3*h and value < 4*h: #Classe24_32
            TEC = (3*h+ 4*h)/2
            print("O valor de TEC é: ",int(TEC))
            return int(TEC)
        elif value >= 4*h and value < 5*h: #Classe32_40
            TEC = (4*h+ 5*h)/2
            print("O valor de TEC é: ",int(TEC))
            return int(TEC)
        elif value >= 5*h and value < 6*h: #Classe40_48
            TEC = (5*h+ 6*h)/2
            print("O valor de TEC é: ",int(TEC))
            return int(TEC)
        elif value >= 6*h and value < 7*h: #Classe48_56
            TEC = (6*h+ 7*h)/2
            print("O valor de TEC é: ",int(TEC))
            return int(TEC)
        elif value >= 7*h and value < 8*h: #Classe56_64
            TEC = (7*h+ 8*h)/2
            print("O valor de TEC é: ",int(TEC))
            return int(TEC)
    
    def TSGenerate(self):
        options = []
        TS = 0
        aux = 0
        for i in range(0,100):
            aux = random.uniform(0,1)
            options.append(aux)

        k = 1 + 3.3*math.log10(100) #7.6 aprox 8
        h = max(options)*100/ k
        
        value = random.choice(options)*100

        if value >= 0.0 and value <= h: #Classe0_8
            TS = (0 + h)/2
            print("O valor de TS é: ",int(TS))
            return int(TS)
        elif value >= h and value < 2*h: #Classe8_16
            TS = (h + 2*h)/2
            print("O valor de TS é: ",int(TS))
            return int(TS)
        elif value >= 2*h and value < 3*h: #Classe16_24
            TS = (2*h + 3*h)/2
            print("O valor de TS é: ",int(TS))
            return int(TS)
        elif value >= 3*h and value < 4*h: #Classe24_32
            TS = (3*h+ 4*h)/2
            print("O valor de TS é: ",int(TS))
            return int(TS)
        elif value >= 4*h and value < 5*h: #Classe32_40
            TS = (4*h+ 5*h)/2
            print("O valor de TS é: ",int(TS))
            return int(TS)
        elif value >= 5*h and value < 6*h: #Classe40_48
            TS = (5*h+ 6*h)/2
            print("O valor de TS é: ",int(TS))
            return int(TS)
        elif value >= 6*h and value < 7*h: #Classe48_56
            TS = (6*h+ 7*h)/2
            print("O valor de TS é: ",int(TS))
            return int(TS)
        elif value >= 7*h and value < 8*h: #Classe56_64
            TS = (7*h+ 8*h)/2
            print("O valor de TS é: ",int(TS))
            return int(TS)

            

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
    


        

    