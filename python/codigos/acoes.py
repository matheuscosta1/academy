import math


def calcula_melhor_lucro(lista):
    numero_maximo_dias_permitido = int(
        input())  # lê do teclado o número máximo permitido de um interval em dias pra comprar e vender uma ação
    quantidade_dinheiro = float(input())  # lê a quantidade de dinheiro que levará na viagem

    dia_da_compra = 0
    dia_da_venda = 0
    valor_da_compra = 0
    valor_venda = 0
    quantidade_acoes_compradas = 0
    lucro = 0

    for i in range(len(lista)): #faz i iterações levando em consideração o tamanho da lista

        if len(lista[i:i + numero_maximo_dias_permitido]) == numero_maximo_dias_permitido: #valida se a quantidade de elementos que vai de i até o numero maximo de dias permitidos é igual ao numero de dias permitidos. por exemplo: length([1,2,3,4,5]) == 5
            menor_valor_no_intervalo = min(lista[i:i + numero_maximo_dias_permitido + 1]) #pega o menor valor de ação da lista
            maior_valor_no_intervalo = max(lista[i:i + numero_maximo_dias_permitido + 1]) #pega o maior valor de ação da lista

            if not (lista.index(menor_valor_no_intervalo) > lista.index(
                    maior_valor_no_intervalo)):  # valida se o menor valor de ação não veio depois do maior valor de ação

                quantidade_acoes = math.floor(
                    quantidade_dinheiro / menor_valor_no_intervalo)  # calcula a quantidade de ações com base na quantidade de dinheiro dividido pelo menor valor de ação e arredonda pra baixo


                lucro_total = (maior_valor_no_intervalo - menor_valor_no_intervalo) * quantidade_acoes #calcula o lucro total para validar se é maior que o lucro final que tenho guardado

                if lucro_total > lucro:
                    valor_da_compra = menor_valor_no_intervalo #valor da compra com base no menor valor no intervalo da lista
                    valor_venda = maior_valor_no_intervalo #valor da venda com base no maior valor no intervalo da lista
                    quantidade_acoes_compradas = quantidade_acoes #atribui a variavel quantidade acoes compradas o calculo de quantidade de acoes
                    lucro = lucro_total #atribui a variavel lucro o lucro total
                    dia_da_compra = lista.index(menor_valor_no_intervalo) + 1 #pega o indice do menor valor que é equivalente ao dia de compra
                    dia_da_venda = lista.index(maior_valor_no_intervalo) + 1 #pega o indice do maior valor que é equivalente ao dia de venda

    print("Dia da compra:", format(dia_da_compra))
    print("Valor de compra: R$", format(valor_da_compra, ".2f"))
    print("Dia da venda:", format(dia_da_venda))
    print("Valor de venda: R$", format(valor_venda, ".2f"))
    print("Quantidade de acoes compradas:", format(quantidade_acoes_compradas))
    print("Lucro: R$", format(lucro, ".2f"))


def main():
    numero_dias = int(input())  # lê a quantidade de dias de preço de ações

    lista_acoes = []  # cria uma lista de ações vazia

    if numero_dias <= 30:  # valida se o número de dias é menor ou igual a 30
        for i in range(numero_dias):  # percorre o numero de dias para receber os valores das ações
            valor_acao = float(input())  # lê do teclado o preço de uma ação
            lista_acoes.append(valor_acao)  # adiciona na lista de ações o preço da ação lida
        calcula_melhor_lucro(lista_acoes)  # chama uma função para calcular o melhor lucro


main()  # invoca a função main
