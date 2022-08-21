using Random: rand
using Distributions: Uniform, Normal
using StatsBase

struct AG
    tampop::Int64
    numgenes::Int64
    probcruzamento::Float64
    probmutação::Float64
    num_máx_gerações::Int64
end

const Cromossomo = Vector{Float64}
const Cromossomos = Vector{Cromossomo}

mutable struct Indivíduo
    cromossomo::Cromossomo
    aptidão::Float64
    valor::Float64

    function Indivíduo(numgenes::Int64, apt=-Inf, valor=-Inf)
	    c::Cromossomo = rand(Uniform(-10, 10), numgenes)
        new(c,apt,valor)
    end

    Indivíduo(c::Cromossomo, apt=-Inf, valor=-Inf) = new(c, apt, valor)
end

const Indivíduos = Vector{Indivíduo}

struct População
    indivíduos::Indivíduos
    tamanho::Int

    function População(tampop,numgenes)
        indivíduos = [ Indivíduo(numgenes) for _ ∈ 1:tampop ]
        new(indivíduos, tampop)
    end

    População(inds::Indivíduos) = new(inds, length(inds))
end

Base.isless(ind1::Indivíduo, ind2::Indivíduo) = ind1.aptidão < ind2.aptidão

function avalia_população!(pop::População)
    for ind in pop.indivíduos
        avalia_indivíduo!(ind)
    end
    sort!(pop.indivíduos, rev=true)
end

function avalia_indivíduo!(indivíduo::Indivíduo)
    x = levy(indivíduo.cromossomo)
    aptidão = aptidão!(x)
    indivíduo.valor = x
    indivíduo.aptidão = aptidão
end


#Função de aptidão (Assintótica no eixo Y, aptidão Infinita quando x tende a zero)
function aptidão!(x::Float64)::Float64
    return x / x^2
end


#Implementação da função de Levy
function levy(x::Cromossomo)::Float64
    termo1 = sin(pi * wi(1,x))^2
    termo2 = somatório(x)
    d = length(x)
    termo3 = (wi(d, x) - 1)^2 * (1 + sin(2*pi*wi(d, x))^2)

    return termo1 + termo2 + termo3
end

function wi(i::Int64, x::Cromossomo)::Float64
    return 1 + ((x[i] - 1) / 4)
end

function somatório(x::Cromossomo)::Float64
    resposta = 0.0
    for i in 1 : length(x)-1
        resposta = resposta + ((wi(i, x) - 1)^2 * (1 + 10 * sin(pi*wi(i, x) + 1)^2))
    end
    return resposta
end


# 1) Implemente métodos de seleção:
# a) por roleta
function seleção_por_roleta(pop::População)::Cromossomos
    indivíduos = pop.indivíduos
    apt_total = sum(ind -> ind.aptidão, indivíduos)

    function gira_roleta()
        agulha = rand() * apt_total
        somaparcial = 0.0
        for i = 1:pop.tamanho
            somaparcial += indivíduos[i].aptidão
            if agulha <= somaparcial
                return i
            end
        end
    end

    return [ copy(indivíduos[gira_roleta()].cromossomo) for _ ∈ 1:pop.tamanho ]
end

# b) por torneio
function seleção_por_torneio(pop::População)::Cromossomos
    indivíduos = pop.indivíduos
    num_competidores = 5

    function seleciona_vencedor()
        selecionados_idx = sample(1:length(indivíduos), num_competidores, replace = false)
        melhor = indivíduos[selecionados_idx[1]]
        for i in 2:num_competidores
            if indivíduos[i] > melhor
                melhor = indivíduos[i]
            end
        end
        return melhor.cromossomo
    end

    return [ copy(seleciona_vencedor()) for _ ∈ 1:pop.tamanho ]
end


# 2) Implemente a mutação para ponto flutuante:
# a) Uniforme 
function mutação_uniforme!(cs::Cromossomos, ag::AG)
    for i=1:ag.tampop, j=1:ag.numgenes
        if rand() < ag.probmutação
            cs[i][j] = rand(Uniform(-10, 10))
        end
    end
end

# b) Não uniforme a partir de uma distribuição Gaussiana
function mutação_não_uniforme!(cs::Cromossomos, ag::AG)
    d = Normal(10, 5)
    for i=1:ag.tampop, j=1:ag.numgenes
        if rand() < ag.probmutação
            cs[i][j] = mod(cs[i][j] + 10 + rand(d), 20) - 10
        end
    end
end


# 3) Implemente operadores de cruzamentos:
# a) Uniforme
function cruzamento_uniforme(c1::Cromossomo, c2::Cromossomo)
    for j in 1 : length(c1)
        if rand(0:100) <= 50
            c1[j], c2[j] = c2[j], c1[j]
        end
    end
    return c1, c2
end

# b) N-Pontos
function cruzamento_n_pontos(cs::Cromossomos)

    tamanhoCromossomo = length(cs[1])
    n::Int8 = mod(3, tamanhoCromossomo) #Número de cortes mod tamanho do cromossomo, para que não haja mais cortes do que elementos
    
    cortes = sort(sample(1:tamanhoCromossomo-1, n, replace = false))
    push!(cortes, tamanhoCromossomo)
    últimoCorte = 1
    indexVetorCorte = 1
    filho1 = []
    filho2 = []

    toggleFilho1 = 1
    toggleFilho2 = 0
    for i in 1:tamanhoCromossomo
        if i == cortes[indexVetorCorte]
            append!(filho1, cs[toggleFilho1+1][últimoCorte:cortes[indexVetorCorte]])
            append!(filho2, cs[toggleFilho2+1][últimoCorte:cortes[indexVetorCorte]])
            indexVetorCorte += 1
            últimoCorte = i + 1
            toggleFilho1 = abs(toggleFilho1-1) #chaveamento para alterar de qual pai o filho receberá os genes a cada iteração
            toggleFilho2 = abs(toggleFilho2-1)
        end
    end

    return cs[1], cs[2]
end

# c) Aritmético simples
function cruzamento_aritmético_simples(c1::Cromossomo, c2::Cromossomo)
    alpha = 0.5
    index = rand(1:length(c1))
    c1[index] = c1[index] * alpha + (1-alpha) * c2[index]
    c2[index] = c2[index] * alpha + (1-alpha) * c1[index]
    return c1, c2
end

# d) Aritmético
function cruzamento_aritmético(c1::Cromossomo, c2::Cromossomo)
    alpha = 0.5
    tamanhoCromossomo = length(c1)
    index = rand(1 : tamanhoCromossomo)

    for i in index:tamanhoCromossomo
        c1[i] = c1[i] * alpha + (1-alpha) * c2[i]
        c2[i] = c2[i] * alpha + (1-alpha) * c1[i]
    end

    return c1, c2
end

# e) Aritmético completo
function cruzamento_aritmético_completo(c1::Cromossomo, c2::Cromossomo)
    alpha = 0.5

    for i in 1:length(c1)
        c1[i] = c1[i] * alpha + (1-alpha) * c2[i]
        c2[i] = c2[i] * alpha + (1-alpha) * c1[i]
    end

    return c1, c2
end


function main()
    tampop::Int64 = 50
    num_máx_gerações::Int64 = 1000
    numgenes::Int64 = 4
    probcruzamento::Float64 = 0.9
    probmutação::Float64 = 0.02
    num_execuções::Int64 = 500
    num_testes::Int64 = 1

    for _ in 1:num_testes
        ag::AG = AG(
            tampop,
            numgenes,
            probcruzamento,
            probmutação,
            num_máx_gerações
        )
        melhores = Indivíduos(undef, num_execuções)
        for j in 1:num_execuções
            pop = executa(ag)
            indivíduos = sort(pop.indivíduos, rev=true)
            melhores[j] = indivíduos[1]
        end
        melhores = sort(melhores, rev=true)
        println("Melhor:\n",
                "    - Aptidão: ", melhores[1].aptidão,",\n",
                "    - Valor: ", melhores[1].valor, "\n",
                "    - Indivíduo: ", melhores[1].cromossomo, "\n"
        )
        println("Pior:\n",
                "    - Aptidão: ", melhores[num_execuções].aptidão,",\n",
                "    - Valor: ", melhores[num_execuções].valor, "\n",
                "    - Indivíduo: ", melhores[num_execuções].cromossomo, "\n"
        )
    end
end

function executa(ag::AG)
    pop = População(ag.tampop, ag.numgenes)
    avalia_população!(pop)

    for _ in 1:ag.num_máx_gerações
        selecionados = seleção_por_roleta(pop)
        # selecionados = seleção_por_torneio(pop)
        cruzamento!(selecionados, ag)
        mutação_uniforme!(selecionados, ag)
        # mutação_não_uniforme!(selecionados, ag)
        pop = População([Indivíduo(s) for s in selecionados])
        avalia_população!(pop)
    end
    pop
end

function cruzamento!(cs::Cromossomos, ag::AG)
    for i=1:2:ag.tampop
        c1 = cs[i]
        c2 = cs[i+1]
        if rand() < ag.probcruzamento
            # c1, c2 = cruzamento_uniforme(c1, c2, ag)
            # c1, c2 = cruzamento_n_pontos([c1, c2])
            c1, c2 = cruzamento_aritmético_simples(c1, c2)
            # c1, c2 = cruzamento_aritmético(c1, c2)
            # c1, c2 = cruzamento_aritmético_completo(c1, c2)
        end
    end
end


main()