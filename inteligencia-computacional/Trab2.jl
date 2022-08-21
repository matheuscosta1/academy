using Evolutionary
using Distributions: Uniform

# Implementação da função de Levy
function levy(x::Vector{Float64})::Float64
    termo1 = sin(pi * wi(1,x))^2
    termo2 = somatório(x)
    d = length(x)
    termo3 = (wi(d, x) - 1)^2 * (1 + sin(2*pi*wi(d, x))^2)

    return termo1 + termo2 + termo3
end

function wi(i::Int64, x::Vector{Float64})::Float64
    return 1 + ((x[i] - 1) / 4)
end

function somatório(x::Vector{Float64})::Float64
    resposta = 0.0
    for i in 1 : length(x)-1
        resposta = resposta + ((wi(i, x) - 1)^2 * (1 + 10 * sin(pi*wi(i, x) + 1)^2))
    end
    return resposta
end

function main()
    for d in [16,24,32]
        print("########## Função Levy otimizada com ", d, " dimensões ##########\n")
        print("##### Algoritmo genético:\n")
        result = Evolutionary.optimize(
            levy,
            BoxConstraints([-10 for i in 1:d], [10 for i in 1:d]),
            GA(
                populationSize = 5000,
                crossoverRate = 0.8,
                mutationRate = 0.2,
                epsilon = 100,
                selection = tournament(5),
                crossover = Evolutionary.IC(1),
                mutation = Evolutionary.gaussian(0.5)
            )
        )
        print(result, "\n * Full Candidate: ", Evolutionary.minimizer(result), "\n\n")

        print("##### Estratégia Evolutiva:")
        result = Evolutionary.optimize(
            levy,
            BoxConstraints([-10 for i in 1:d], [10 for i in 1:d]),
            ES(
                initStrategy = IsotropicStrategy(d),
                recombination = average,
                srecombination = average,
                mu = 100,
                rho = 50,
                lambda = 200,
                mutation = Evolutionary.gaussian,
                smutation = Evolutionary.gaussian,
                selection = :plus
            )
        )
        print(result, "\n * Full Candidate: ", Evolutionary.minimizer(result), "\n\n")
    end
end

main()