module Grafo
   (
        éTrivial,
        éVazio,
        éIsolado,
        éNulo,
        éTerminal,
        éPar,
        éImpar,
        seqGraus,
        grauMax,
        grauMin,
        éRegular,
        éKRegular,
        éCompleto,
        éKn,
        grafoCompleto,
        grafoComplemento,
        éSubgrafo,
        éSubgrafoPróprio,
        éSubgrafoInduzidoVértices,
        éSubgrafoInduzidoArestas,
        éClique,
        éCjIndependenteVértices,
        união,
        interseção,
        fundeVértices,
        contraiVértices,
        contraiAresta,
        éPasseio,
        éPasseioAberto,
        éPasseioFechado,
        éTrilha,
        éCaminho,
        éCiclo,
        éGrafoCíclico,
        éCn,
        éGrafoCaminho,
        éPn,
        éGrafoBipartido,
        éTrilhaEuleriana,
        éGrafoEuleriano,
        éSemiEuleriano,
        éHamiltonianoDirac,
        éConexo,
        ciclo,
        distância,
        excentricidade,
        raio,
        diâmetro,
        centro,
        éArticulação,
        éPonte,
        conectividade,
        éBiconexo,
        éÁrvore,
        éEstrela,
        éFloresta,
        folhas,
        internos,
        centroÁrvore,
        éAncestral,
        éDescendente,
        éIrmão,
        nível,
        nivel,
        éÁrvoreBin,
        estrito,
        éÁrvoreBinEstrita,
        éÁrvoreM,
        éÁrvoreMcheia,
        prufer,
        decodPrufer,
        éSeqVálida,
        numÁrvRotuladas,
        éEmparelhamento,
        éEmpMaximal,
        éEmpPerfeito,
        éCaminhoAlternante,
        éCaminhoAumentador,
        éDesconectador,
        éSeparador,
        coberturaVértices,
        suavizaVértice,
        suaviza,
        coloreVérticesIngênuo
   ) where

import GrafoListAdj
import Data.List
import System.Random
import System.Random.Shuffle 
import Control.Monad


--sudo apt-get install cabal-install cabal update
--cabal install random
--sudo apt install libghc-random-shuffle-dev

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Utils

removeRepetidos [] lista = []
removeRepetidos lista [] = lista
removeRepetidos (a:x) (b:y)
    | elem a (b:y) = removeRepetidos x (b:y)
    | otherwise = a : removeRepetidos x (b:y)

semTuplasIguais:: [(Int, Int)] -> [(Int, Int)]
semTuplasIguais [] = []
semTuplasIguais (x:xs)
    | fst x /= snd x = x:semTuplasIguais xs
    | otherwise = semTuplasIguais xs

éVérticeRepetido:: [Int] -> Bool
éVérticeRepetido [] = True
éVérticeRepetido (x:xs)
    | elem x xs = False
    | otherwise = éVérticeRepetido xs

ultimoVertice :: [a] -> a
ultimoVertice = foldr1 (\_ a -> a)

verificaSeAsArestasSaoDiferentes :: [(Int, Int)] -> Bool
verificaSeAsArestasSaoDiferentes [] = True
verificaSeAsArestasSaoDiferentes [_] = True
verificaSeAsArestasSaoDiferentes ((x, h):arvore) 
    |   elem (x, h) arvore || elem (h, x) arvore = False
    |   otherwise = verificaSeAsArestasSaoDiferentes arvore

verificaSeOsVerticesSaoDiferentes :: [Int] -> Bool
verificaSeOsVerticesSaoDiferentes [] = True
verificaSeOsVerticesSaoDiferentes [_] = True
verificaSeOsVerticesSaoDiferentes (h:arvore) 
    |   elem h arvore = False
    |   otherwise = verificaSeOsVerticesSaoDiferentes arvore

retiraExtremidades :: [a] -> [a]
retiraExtremidades [] = []
retiraExtremidades [h] = []
retiraExtremidades arvore = tail (init arvore)

montaPossíveisArestas [] = []
montaPossíveisArestas [_] = []
montaPossíveisArestas (x:y:arvore) = [(x, y)] ++ montaPossíveisArestas (x:arvore) ++ montaPossíveisArestas (y:arvore) 

quantidadeImpares  [] = 0
quantidadeImpares  (x:y)
    |   odd x == True = 1 + (quantidadeImpares y)
    |   otherwise = quantidadeImpares y

verificaSeOsVérticesSãoAdjacentes grafo [a] = True
verificaSeOsVérticesSãoAdjacentes grafo [] = True
verificaSeOsVérticesSãoAdjacentes grafo (a:b:arvore)  
    |   not (adjacente grafo a b) = False
    |   otherwise = verificaSeOsVérticesSãoAdjacentes grafo (b:arvore)

constróiArestasAPartirDosVértices [] = []
constróiArestasAPartirDosVértices [_] = []
constróiArestasAPartirDosVértices (x:y:arvore) = [(x, y)] ++ constróiArestasAPartirDosVértices (y:arvore) 

comumEntreDuasListas [] a = []
comumEntreDuasListas a [] = a
comumEntreDuasListas (a:x) (b:y)
    | elem a (b:y) = a: comumEntreDuasListas x (b:y)
    | otherwise = comumEntreDuasListas x (b:y)

geraTuplas numero = ([(x, y)| x <- [1..numero], y <- [x..numero]])

zipList :: [a] -> [b] -> [(a,b)]
zipList [] ys = []
zipList (x:xs) [] = []
zipList (x:xs) (y:ys) = (x,y) : zipList xs ys

pegaTodasAsTuplasAPartirDoPrimeiroValor :: Ord a => [(a, b)] -> [(a, b)]
pegaTodasAsTuplasAPartirDoPrimeiroValor [] = []
pegaTodasAsTuplasAPartirDoPrimeiroValor xs = filter ((==) primeiroMinimo . fst) xs
    where primeiroMinimo = minimum (map fst xs)

remove element list = filter (\e -> e/=element) list

verificaSeTodosOsElementosDaListaSaoIguais xs = and $ map (== head xs) (tail xs)

fatorial 0 = 1
fatorial verticeN = fatorial (verticeN - 1) * verticeN

fatorialBaixo [x] = fatorial (x-1)
fatorialBaixo (x:xs) =  (fatorial (x-1)) * (fatorialBaixo xs)

fatorialCima x = fatorial (x-2)

quantidadeDeVerticesEParOuImpar grafo = ((length(vértices grafo)) `div` 2 == 0)

append' :: a -> [[a]] -> [[a]]
append' x = map ((:) x)

randomIntRange (a, b) = getStdRandom $ randomR (a, b)


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Primeira parte:

éTrivial grafo
    | ((length (vértices grafo)) == 1) && (length (arestas grafo) == 0) = True
    | otherwise = False

éVazio grafo
    | (length (arestas grafo) == 0) = True
    | otherwise = False

éIsolado grafo vertice
    | ((grau grafo vertice) == 0) = True
    | otherwise = False

éNulo grafo
    | ((length (vértices grafo)) == 0) && (length (arestas grafo) == 0) = True
    | otherwise = False

éTerminal grafo vertice
    | ((grau grafo vertice) == 1) = True
    | otherwise = False

éPar grafo vertice
    | (mod (grau grafo vertice) 2) == 0 = True
    | otherwise = False

éImpar grafo vertice
    | (éPar grafo vertice) /= True = True
    | otherwise = False

seqGraus grafo = sort (map (grau grafo) (vértices grafo))

grauMax grafo = last(seqGraus grafo)

grauMin grafo = head(seqGraus grafo)

éRegular grafo
    | (grauMax grafo) == (grauMin grafo) = True
    | otherwise = False

éKRegular grafo
    | éRegular grafo = if grauMax grafo == ((length(vértices grafo))-1) then True else False
    | otherwise = False

éCompleto grafo = resultado
    where
     numeroArestas = (length(arestas grafo))
     numeroVertices = (length(vértices grafo))
     resultado = if (numeroArestas == (div(numeroVertices*(numeroVertices-1)) 2 ) && numeroVertices > 0) then True else False

éKn grafo vertice
    | ((éCompleto grafo) && ((length(vértices grafo)) == vertice)) = True 
    | otherwise = False

grafoCompleto numeroVertices = novoGrafo numeroVertices (semTuplasIguais(geraTuplas numeroVertices))

grafoComplemento grafo = resultado
    where
        numeroVertices = (length(vértices grafo))
        novasArestas = (semTuplasIguais(geraTuplas numeroVertices))
        complemento = removeRepetidos novasArestas (arestas grafo)
        resultado = novoGrafo numeroVertices complemento

éSubgrafo grafoH grafoG
    | ((((length(vértices grafoG)) >= (length(vértices grafoH))) && ((length(arestas grafoG)) >= (length(arestas grafoH)))) && null(removeRepetidos (arestas grafoH) (arestas grafoG)) && null(removeRepetidos (vértices grafoH) (vértices grafoG))) = True
    | otherwise = False

éSubgrafoPróprio grafoH grafoG
    | ((((length(vértices grafoG)) > (length(vértices grafoH))) || ((length(arestas grafoG))>(length(arestas grafoH))) ) && null(removeRepetidos (arestas grafoH) (arestas grafoG)) && null(removeRepetidos (vértices grafoH) (vértices grafoG))) = True
    | otherwise = False

éSubgrafoInduzidoVértices grafoH grafoG listaVertices = resultado
    where
        ajustaGrafo = head((map (removeVértice grafoG) (removeRepetidos (vértices grafoG) listaVertices)))
        resultado = ((éSubgrafo grafoH grafoG) && (null(removeRepetidos listaVertices (vértices grafoH)))&& (null(removeRepetidos listaVertices (vértices grafoG))) && ((arestas grafoH) == (arestas(ajustaGrafo))))

éSubgrafoInduzidoArestas grafoH grafoG listaArestas = ((éSubgrafo grafoH grafoG) && (null(removeRepetidos listaArestas (arestas grafoH))) && (null(removeRepetidos listaArestas (arestas grafoG))))

éClique grafoH grafoG = ((éSubgrafo grafoH grafoG) && (éCompleto grafoH))

éCjIndependenteVértices grafoH grafoG
    | éVazio grafoH = True
    | otherwise = ((éSubgrafoInduzidoVértices grafoH grafoG (vértices grafoG)) && (éVazio grafoH))

união grafoH grafoG = resultado 
    where
       novosVertices = (removeRepetidos (vértices grafoH) (vértices grafoG))
       numeroVertices = (length(((vértices grafoG)++novosVertices)))
       novasArestas = (removeRepetidos (arestas grafoH) (arestas grafoG))
       arestasGrafo = ((arestas grafoG)++novasArestas)
       resultado = novoGrafo numeroVertices arestasGrafo

interseção grafoH grafoG = resultado 
    where
       verticesComuns = (comumEntreDuasListas (vértices grafoH) (vértices grafoG))
       arestasComuns = (comumEntreDuasListas (arestas grafoH) (arestas grafoG))
       resultado = novoGrafo (length (verticesComuns)) (arestasComuns)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Segunda parte:

fundeVértices grafo vertice1 vertice2 = removeVértice (novoGrafo numeroVertices (a++arestasFiltradas)) maximo
    where
        numeroVertices = length(vértices grafo) - 1
        minimo = min vertice1 vertice2
        maximo = max vertice1 vertice2
        a = [(a1, minimo) | a1 <- vizinhos grafo maximo]
        resultadoArestas = [(a1, a2) | (a1, a2) <- arestas grafo]
        arestasFiltradas = filter (\(x,y) -> x /= maximo && y /= maximo) resultadoArestas

contraiVértices grafo vértice1 vértice2 = removeVértice (novoGrafo resultado fusão) (max vértice1 vértice2)
    where 
        fusão = arestas (fundeVértices grafo vértice1 vértice2)
        resultado = length(vértices grafo) - 1
 
contraiAresta grafo (aresta1, aresta2) = novoGrafo resultado fusão
    where
        arestaRemovida = removeAresta grafo (aresta1, aresta2)
        fusão = arestas (fundeVértices arestaRemovida aresta1 aresta2)
        resultado = length(vértices grafo) - 1

éPasseio grafo listaVértices = verificaSeOsVérticesSãoAdjacentes grafo listaVértices

éPasseioAberto grafo listaVértices = (éPasseio grafo listaVértices) && head(listaVértices) /= ultimoVertice(listaVértices)
 
éPasseioFechado grafo listaVértices = (éPasseio grafo listaVértices) && head(listaVértices) == ultimoVertice(listaVértices)

éTrilha grafo listaVértices = (éPasseio grafo listaVértices) && resultado
    where 
        resultado = verificaSeAsArestasSaoDiferentes (constróiArestasAPartirDosVértices listaVértices)

éCaminho grafo listaVértices = (éTrilha grafo listaVértices) && (verificaSeOsVerticesSaoDiferentes listaVértices)

éCiclo grafo listaVértices = (éTrilha grafo resultado) && extremosIguais
    where 
        extremosIguais = (head(listaVértices) == ultimoVertice(listaVértices))
        resultado = retiraExtremidades listaVértices
 
éGrafoCíclico grafoC = éKRegular grafoC
 
éCn grafo numeroVértices = (éGrafoCíclico grafo) && length(vértices grafo) == numeroVértices
 
éGrafoCaminho grafo = éCaminho grafo (vértices grafo)

éPn p numeroVértices = (éGrafoCaminho p) && length(vértices p) == numeroVértices

éGrafoBipartido grafo v1 v2 = pegaAdjacentes && (naoAdjacentes v1) || (naoAdjacentes v2)
 where
    pegaAdjacentes = foldr (&&) True [adjacente grafo x y | x <- v1, y <- v2]
    naoAdjacentes v = foldr (&&) True [not (adjacente grafo x y) | (x, y) <- (montaPossíveisArestas v)]

éTrilhaEuleriana grafo arvore = (éTrilha grafo arvore) && (foldr (&&) True trilha) && (length(trilha) == length (arestas grafo))
    where
        trilha = [adjacente grafo x y | (x, y) <- (constróiArestasAPartirDosVértices arvore)]

éGrafoEuleriano grafo = resultado
    where
        resultado = foldr (&&) True [even x | x <- seqGraus grafo]

éSemiEuleriano grafo = quantidadeImpares (seqGraus grafo) == 2

éHamiltonianoDirac grafo = quantidadeVértices >= 3 && grau
    where
        quantidadeVértices = length(vértices grafo)
        grau = foldr (&&) True [length(vizinhos grafo v) >= (div quantidadeVértices 2) | v <- vértices grafo]

------------------------------------------------------------------------------------------------------------------------------------
-- Trabalho 4


bfs grafo visitados [] = visitados
bfs grafo visitados (x:y) = bfs grafo novosVisitados fila
    where
        fila = y ++ [adj | adj <- vizinhos grafo x, not (elem adj visitados)]
        novosVisitados = if not (elem x visitados) then visitados ++ [x] 
        else visitados

buscaLargura grafo = bfs grafo [head (vértices grafo)] [head (vértices grafo)] 

dfs grafo visitados [] = visitados
dfs grafo visitados (x:y) = dfs grafo novosVisitados pilha
    where
        pilha = [adj | adj <- vizinhos grafo x, not (elem adj visitados)] ++ y
        novosVisitados = if not (elem x visitados) then visitados ++ [x] 
        else visitados

buscaProfundidade grafo = dfs grafo [head (vértices grafo)] [head (vértices grafo)] 

éConexo grafo = foldr (&&) True [not(éIsolado grafo vertice) | vertice <- vértices grafo]

ciclo grafo [] = []
ciclo grafo vertice = resultado
    where 
        listaVértices = dfs grafo vertice vertice
        tiraRepetidos = removeRepetidos (vértices grafo) listaVértices
        resultado = if ((length(listaVértices) > 1)) then listaVértices else (ciclo grafo [head(tiraRepetidos)])

incrementar x = x + 1

resultado = 0
components grafo = resultado 
    where
        primeiroVértice = (buscaProfundidade grafo)
        tiraRepetidos = removeRepetidos (vértices grafo) primeiroVértice   
        resultado = components grafo

reverseE grafo = [ (w,v) | (v,w) <- arestas grafo]

undirected grafo = novoGrafo (length(vértices grafo)) (arestas grafo ++ reverseE grafo)

bfsMC grafo menorCaminho [] v = menorCaminho 
bfsMC grafo menorCaminho (x:y) v 
    |   x == v = menorCaminho ++ [v]
    |   otherwise = bfsMC grafo novosVisitados fila v
    where
        fila = y ++ [adj | adj <- vizinhos grafo x, not (elem adj menorCaminho)]
        novosVisitados = if not (elem x menorCaminho) && (adjacente grafo x v) && (checa grafo v menorCaminho) then menorCaminho ++ [x] 
        else menorCaminho
            where 
                checa grafo x [] = True
                checa grafo x (y:z) = if (adjacente grafo x y) then False
                else checa grafo x z

menorCaminho grafo vérticeU vérticeV = bfsMC grafo [vérticeU] [vérticeU] vérticeV

distância grafo vérticeU vérticeV = length(menorCaminho grafo vérticeU vérticeV) - 1

excentricidade grafo vérticeV =  maximum (map (distância grafo vérticeV) [x | x <- vértices grafo, x /= vérticeV && (elem x (vértices grafo))])

pegaValorDasExcentricidadesDosVértices grafo [] = []
pegaValorDasExcentricidadesDosVértices grafo (x:xs) = excentricidade grafo x : (pegaValorDasExcentricidadesDosVértices grafo xs)

minimaExcentricidade grafo = minimum(pegaValorDasExcentricidadesDosVértices grafo (vértices grafo))

maximaExcentricidade grafo = maximum(pegaValorDasExcentricidadesDosVértices grafo (vértices grafo))

raio grafo = minimaExcentricidade grafo

diâmetro grafo = maximaExcentricidade grafo

mapVérticeEExcentricidadeEmUmaTupla grafo = zipList (pegaValorDasExcentricidadesDosVértices grafo (vértices grafo)) (vértices grafo) 

centro grafo = map snd (pegaTodasAsTuplasAPartirDoPrimeiroValor((mapVérticeEExcentricidadeEmUmaTupla grafo)))

éArticulação grafo vérticeX = resultado
    where
        éConectadoAntes = if (length(dfs grafo [vérticeX] [vérticeX]) > 1) then True else False
        vizinhosX = vizinhos grafo vérticeX
        novoGrafoDepoisRemoverVerticeX = removeVértice grafo (head vizinhosX)
        éConectadoDepois = if (length(dfs novoGrafoDepoisRemoverVerticeX [vérticeX] [vérticeX]) > 1) then True else False
        resultado = if ((éConectadoAntes == éConectadoDepois)) then True else False

éPonte grafo (aresta1, aresta2) = resultado
    where
        tamanhoVerticesAntes = length(buscaLargura grafo)
        novoGrafoDepoisRemoverArestas = removeAresta grafo (aresta1, aresta2)
        tamanhoVerticesDepois = length(buscaLargura novoGrafoDepoisRemoverArestas)
        resultado = if ((tamanhoVerticesAntes == tamanhoVerticesDepois)) then False else True

conectividade grafo
    | éCompleto grafo = length(vértices grafo) - 1
    | (éConexo grafo) && (length(vértices grafo) >= 3) = length(vértices grafo) - 2
    | otherwise = 0

pegaValoresArticulacoesVertices grafo = map (éArticulação grafo) (vértices grafo)

éBiconexo grafo = resultado
    where
        conexo = éConexo grafo
        articulacoes = pegaValoresArticulacoesVertices grafo
        resultado = if (conexo) && (elem True articulacoes) then False else True

------------------------------------------------------------------------------------------------------------------------------------
-- Trabalho 5

nãoéCircuito grafo visitados [] = True
nãoéCircuito grafo visitados (x:y) 
    |   (elem x visitados) = False
    |   otherwise = nãoéCircuito grafo novosVisitados pilha
    where
        pilha = [adj | adj <- vizinhos grafo x, not (elem adj visitados)] ++ y
        novosVisitados = visitados ++ [x]

éÁrvore grafo = éConexo grafo && (nãoéCircuito grafo [] [head(vértices grafo)])
 
éEstrela grafo = primeiro && meio && verticeN
    where
        verticeN = (ultimoVertice (seqGraus grafo)) == (length (vértices grafo) - 1)
        primeiro = head(seqGraus grafo) == 1
        meio = foldr (&&) True (map (== 1) (retiraExtremidades(seqGraus grafo)))

éFloresta grafo = not(éConexo grafo) && (nãoéCircuito grafo [] [head(vértices grafo)])

internos grafo = resultado
    where
        vertices = zipList(map (grau grafo) (vértices grafo)) (vértices grafo)
        resultado = map snd (filter ((>1).fst) vertices)

folhas grafo = [v | v <- (vértices grafo), (length(vizinhos grafo v) == 1)]

centroÁrvore grafo = map snd (pegaTodasAsTuplasAPartirDoPrimeiroValor((mapVérticeEExcentricidadeEmUmaTupla grafo)))

éAncestral arvore raiz verticeV verticeW = resultado
    where
        path = dfs arvore [raiz] [verticeW]
        resultado = if verticeV `elem` path then True else False

éDescendente arvore raiz verticeV verticeW = éAncestral arvore raiz verticeV verticeW

éFilho grafo verticeV verticeW = resultado 
    where
        primeiroVertice = (filter ((==verticeW).fst) (arestas grafo))
        resultado = verticeV `elem` (map snd primeiroVertice)

éPai arvore verticeV verticeW = resultado
    where
        resultado = éFilho arvore verticeW verticeV

pegaVerticePai arvore raiz vertice (x:xs) = if(vertice == raiz) then [] else if (éFilho arvore vertice x) then [x] else (pegaVerticePai arvore raiz vertice xs)

éIrmão arvore raiz verticeV verticeW = resultado
    where 
        filho1 = pegaVerticePai arvore raiz verticeV (vértices arvore)
        filho2 = pegaVerticePai arvore raiz verticeW (vértices arvore)
        resultado = filho1 == filho2

nível:: Grafo -> Int -> Int -> Int
nível arvore raiz vertice = resultado 
    where 
    resultado = distância arvore raiz vertice

nivel:: Grafo -> Int -> Int
nivel arvore raiz = maximum(map(distância arvore raiz) (vértices arvore))

mapeaQuantidadeDeFilhosDeUmVertice arvore [] = []
mapeaQuantidadeDeFilhosDeUmVertice arvore (x:xs) = resultado
    where 
        verticeEQuantidadeDeFilhos = zipList [x] [(length(filter (==True) (map (éPai arvore x) (vértices arvore))))]
        resultado = verticeEQuantidadeDeFilhos ++ mapeaQuantidadeDeFilhosDeUmVertice arvore xs

éÁrvoreBin arvore raiz = resultado
    where
        verticeEQuantidadeDeFilhos = mapeaQuantidadeDeFilhosDeUmVertice arvore (internos arvore)
        resultado = if null(filter ((>2).snd) verticeEQuantidadeDeFilhos) then True else False

estrito grafo visitados [] = True
estrito grafo visitados (x:y)
    |   ((checa_vizinhos) == False) = False
    |   otherwise = estrito grafo novosVisitados fila
    where
        filhos = [adj | adj <- vizinhos grafo x, not (elem adj visitados)]
        tamanho = length(filhos)
        checa_vizinhos = (tamanho == 0 || tamanho == 2) 
        fila = filhos ++ y
        novosVisitados = if not (elem x visitados) then visitados ++ [x] else visitados

éÁrvoreBinEstrita arvore = (éÁrvore arvore) && (estrito arvore [] [head(vértices arvore)])

arvoreMAria listaArestas grafo visitados [] = True
arvoreMAria listaArestas grafo visitados (x:y)
    |   ((checa_vizinhos) == False) = False
    |   otherwise = arvoreMAria listaArestas grafo novosVisitados fila
    where
    filhos = [adj | adj <- vizinhos grafo x, not (elem adj visitados)]
    tamanho = length(filhos)
    checa_vizinhos = (tamanho <= listaArestas) 
    fila = filhos ++ y
    novosVisitados = if not (elem x visitados) then visitados ++ [x] else visitados

éÁrvoreM arvore listaArestas = (éÁrvore arvore) && (arvoreMAria listaArestas arvore [head(vértices arvore)] [head(vértices arvore)])

éÁrvoreMcheia arvore raiz listaArestas = resultado
    where
        quantidadeFilhosDosVerticesInternos = map snd (mapeaQuantidadeDeFilhosDeUmVertice arvore (internos arvore))
        quantidadeDeVerticesComMFilhos = (filter (==listaArestas) (quantidadeFilhosDosVerticesInternos))
        resultado = length(quantidadeDeVerticesComMFilhos) == length(quantidadeFilhosDosVerticesInternos)

prufer arvore = prufer arvore [] 
    where 
    prufer arvore lista 
        |   not(éÁrvore arvore) = []
        |   (length(vértices arvore) == 2) = [head(vértices arvore)] ++ []
        |   otherwise = k ++ (prufer novo_g nova_lista)
        where
            j = minimum(folhas arvore)
            k = (vizinhos arvore j)
            novo_g = (removeVértice arvore j)
            nova_lista = (lista ++ [j])

decodPrufer c =
    let verticeN = length(c) + 2 in novoGrafo verticeN (decod c [1..verticeN])
    where
    decod [] (x:xs:[]) = [(x,xs)]
    decod v l = 
        let 
        i = minimum(filter (\y -> not(elem y v)) l)
        j = head(v) in [(i,j)] ++ decod (tail v) (filter (/= i) l)

éSeqVálida s = (sum s) == (2*(length s) - 2)

numÁrvRotuladas s = div (fatorialCima (length s)) (fatorialBaixo s)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Trabalho 6

éEmparelhamento grafo listaArestas = null (listaArestas \\ arestas grafo) && distinct (concatMap (\(a,b) -> [a,b]) listaArestas) 
    where distinct xs = nub xs == xs

éEmpMaximal grafo listaArestas = éEmparelhamento grafo listaArestas && and [a `elem` ns || b `elem` ns | (a,b) <- arestas grafo]
    where ns = nub $ concatMap (\(a,b) -> [a,b]) listaArestas

éEmpPerfeito grafo listaArestas = resultado
    where 
        listaVérticesSaturados = sort((map fst listaArestas) ++ (map snd listaArestas))
        resultado = éEmparelhamento grafo listaArestas && (listaVérticesSaturados == (vértices grafo))

éCaminhoAlternante grafo arestasDoEmparelhamento caminho = resultado
    where
        arestasDoCaminho = constróiArestasAPartirDosVértices caminho
        pegaDuasPrimeirasArestasDoCaminho = take 2 arestasDoCaminho
        comumEntreDuasPrimeirasArestasDoCaminhoEEmparelhamento = comumEntreDuasListas pegaDuasPrimeirasArestasDoCaminho arestasDoEmparelhamento
        caminhoComACabeçaRemovida = remove (head caminho) caminho
        resultado = if (éEmparelhamento grafo arestasDoEmparelhamento) && length(comumEntreDuasPrimeirasArestasDoCaminhoEEmparelhamento) == 1 && length(arestasDoCaminho) == 2 then True else if (length(arestasDoCaminho) > 0) then éCaminhoAlternante grafo arestasDoEmparelhamento caminhoComACabeçaRemovida else False

éCaminhoAumentador grafo arestasDoEmparelhamento caminho = resultado
    where
        listaVérticesSaturados = nub (sort((map fst arestasDoEmparelhamento) ++ (map snd arestasDoEmparelhamento)))
        resultado = (éCaminhoAlternante grafo arestasDoEmparelhamento caminho) && not((head caminho) `elem` listaVérticesSaturados) && not((last caminho) `elem` listaVérticesSaturados)

removeVértices grafo [] = grafo
removeVértices grafo (x:xs) = resultado
    where
        novoGrafo = removeVértice grafo x
        resultado = removeVértices novoGrafo xs

éDesconectador grafo verticeX verticeW listaArestasDesconectadoras = resultado
    where
        éConectadoAntes = if ((verticeX `elem` buscaLargura grafo) &&  (verticeW `elem` buscaLargura grafo)) then True else False
        arestasDoGrafoSemArestasDesconectadoras = removeRepetidos (arestas grafo) listaArestasDesconectadoras
        quantidadeVerticesAposRemoçãoArestas = nub (sort((map fst arestasDoGrafoSemArestasDesconectadoras) ++ (map snd arestasDoGrafoSemArestasDesconectadoras)))
        novoGrafoX = novoGrafo (length(quantidadeVerticesAposRemoçãoArestas)) arestasDoGrafoSemArestasDesconectadoras
        éConectadoDepois = if ((verticeX `elem` buscaLargura novoGrafoX) && (verticeW `elem` buscaLargura novoGrafoX)) then True else False
        resultado = if (éConectadoAntes && not(éConectadoDepois)) then True else False

éSeparador grafo verticeX verticeW listaVérticesSeparadores = resultado
    where
        éConectadoAntes = if ((verticeX `elem` buscaLargura grafo) &&  (verticeW `elem` buscaLargura grafo)) then True else False
        novoGrafoX = removeVértices grafo listaVérticesSeparadores
        éConectadoDepois = if ((verticeX `elem` buscaLargura novoGrafoX) && (verticeW `elem` buscaLargura novoGrafoX)) then True else False
        resultado = if (éConectadoAntes && not(éConectadoDepois)) then True else False

cobertura grafo [] = []
cobertura grafo ((x,y):xs) = [x,y] ++ (cobertura novo_g nova_a) 
    where
    g_semX = (removeVértice grafo x)
    novo_g = (removeVértice g_semX y)
    nova_a = (arestas novo_g)

coberturaVértices grafo = (cobertura grafo (arestas grafo))

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Trabalho 7


suavizaVértice grafo vérticeV = resultado
    where
        éGrau2 = ((grau grafo (vérticeV)) == 2)
        vizinhosV = vizinhos grafo vérticeV
        resultado = if éGrau2 then (contraiVértices grafo vérticeV (head vizinhosV)) else grafo

contraiListaVértices grafo [] = grafo
contraiListaVértices grafo (x:xs) = resultado
    where
        novoGrafo = if (null(vizinhos grafo x)) then grafo else (contraiVértices grafo x (head (vizinhos grafo x)))
        resultado = contraiListaVértices novoGrafo xs

suaviza grafo = resultado
    where
        listaVérticesESeusGraus = zipList(map (grau grafo) (vértices grafo)) (vértices grafo)
        vérticesComGrau2 = map snd (filter ((==2).fst) listaVérticesESeusGraus)
        resultado = contraiListaVértices grafo vérticesComGrau2

criaListaCores grafo = take ((grauMax grafo)+1) [1..]

pegaTodosOsVérticesAdjacentesAoVerticeX grafo verticeX [] = []
pegaTodosOsVérticesAdjacentesAoVerticeX grafo verticeX (x:xs) = resultado
    where
        resultado = if adjacente grafo verticeX x then [x] ++ pegaTodosOsVérticesAdjacentesAoVerticeX grafo verticeX xs else (pegaTodosOsVérticesAdjacentesAoVerticeX grafo verticeX xs)

verificaSeOVerticeXPossuiUmaDadaCor verticeX cor listaDeVérticesECoresNormalizada = resultado
    where
        corDoVérticeX = map snd (filter ((==verticeX).fst) listaDeVérticesECoresNormalizada)
        resultado = if cor `elem` corDoVérticeX then True else False

verificaSeOVerticeXEstáColorido verticeX listaDeVérticesECoresNormalizada = resultado
    where
        verticeXTemCor = map snd (filter ((==verticeX).fst) listaDeVérticesECoresNormalizada)
        resultado = if (length(verticeXTemCor) > 0) then True else False

percorreTodosOsVérticesAdjacentesEVerificaSePossuiADadaCor [] cor listaDeVérticesECoresNormalizada = False
percorreTodosOsVérticesAdjacentesEVerificaSePossuiADadaCor vérticesAdjacentes cor [] = False
percorreTodosOsVérticesAdjacentesEVerificaSePossuiADadaCor (x:xs) cor listaDeVérticesECoresNormalizada = resultado
    where 
        éCorDoVérticeAdjacente = (verificaSeOVerticeXPossuiUmaDadaCor x cor listaDeVérticesECoresNormalizada)
        resultado = if éCorDoVérticeAdjacente then True else if not(null(xs)) then percorreTodosOsVérticesAdjacentesEVerificaSePossuiADadaCor xs cor listaDeVérticesECoresNormalizada else False

--grafo listaVértices cores listaDeVérticesColoridos
percorreVértices grafo [] cores listaDeVérticesColoridos = listaDeVérticesColoridos
percorreVértices grafo (x:xs) cor listaDeVérticesColoridos = resultado
    where
        verticeEstáColorido = verificaSeOVerticeXEstáColorido x listaDeVérticesColoridos
        vérticesAdjacentes = pegaTodosOsVérticesAdjacentesAoVerticeX grafo x (vértices grafo)
        vérticeXPossuiACor = percorreTodosOsVérticesAdjacentesEVerificaSePossuiADadaCor vérticesAdjacentes cor (listaDeVérticesColoridos)
        verticesColoridos = if (vérticeXPossuiACor || verticeEstáColorido) then listaDeVérticesColoridos else listaDeVérticesColoridos ++ [(x, cor)]
        resultado = percorreVértices grafo xs cor verticesColoridos

percorreCores grafo listaVértices [] listaDeVérticesColoridos = listaDeVérticesColoridos
percorreCores grafo listaVértices (x:xs) listaDeVérticesColoridos = resultado
    where
        percorreVérticesX = percorreVértices grafo listaVértices x listaDeVérticesColoridos
        resultado = percorreCores grafo listaVértices xs percorreVérticesX

coloreVérticesIngênuo grafo listaVértices = resultado
    where
        cores = criaListaCores grafo
        resultado = percorreCores grafo listaVértices cores []

g42 = novoGrafo 10 [(1,2),(1,3),(2,4),(3,5),(4,5),(1,6),(2,7),(3,8),(4,9),(5,10),(6,9),(6,10),(7,8),(7,10),(8,9)]
xs = vértices g42

pegaTamanhoCromático x = length(nub(map snd x))

main :: IO ()
main = do
    let verticesGrafo = (vértices g42)
    resultadoVerticesEmbaralhados <- shuffleM verticesGrafo
    
    let resultadoGrafoColorido = (coloreVérticesIngênuo g42 resultadoVerticesEmbaralhados)

    let numeroCromatico = pegaTamanhoCromático resultadoGrafoColorido

    putStrLn("------------------------")
    putStrLn("Vértices embaralhados: ")
    print $ resultadoVerticesEmbaralhados
    putStrLn("------------------------")
    putStrLn("Grafo colorido [(vértice, cor)]: ")
    print $ resultadoGrafoColorido
    putStrLn("------------------------")
    putStrLn("Número cromático: ")
    print $ numeroCromatico
    putStrLn("------------------------")

doSomething :: [Integer] -> Integer
doSomething = sum