import GrafoListAdj
import Data.List

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
verificaSeAsArestasSaoDiferentes ((x, h):t) 
    |   elem (x, h) t || elem (h, x) t = False
    |   otherwise = verificaSeAsArestasSaoDiferentes t

verificaSeOsVerticesSaoDiferentes :: [Int] -> Bool
verificaSeOsVerticesSaoDiferentes [] = True
verificaSeOsVerticesSaoDiferentes [_] = True
verificaSeOsVerticesSaoDiferentes (h:t) 
    |   elem h t = False
    |   otherwise = verificaSeOsVerticesSaoDiferentes t

retiraExtremidades :: [a] -> [a]
retiraExtremidades [] = []
retiraExtremidades [h] = []
retiraExtremidades t = tail (init t)

montaPossíveisArestas [] = []
montaPossíveisArestas [_] = []
montaPossíveisArestas (x:y:t) = [(x, y)] ++ montaPossíveisArestas (x:t) ++ montaPossíveisArestas (y:t) 

quantidadeImpares  [] = 0
quantidadeImpares  (x:y)
    |   odd x == True = 1 + (quantidadeImpares y)
    |   otherwise = quantidadeImpares y

verificaSeOsVérticesSãoAdjacentes grafo [a] = True
verificaSeOsVérticesSãoAdjacentes grafo [] = True
verificaSeOsVérticesSãoAdjacentes grafo (a:b:t)  
    |   not (adjacente grafo a b) = False
    |   otherwise = verificaSeOsVérticesSãoAdjacentes grafo (b:t)

constróiArestasAPartirDosVértices [] = []
constróiArestasAPartirDosVértices [_] = []
constróiArestasAPartirDosVértices (x:y:t) = [(x, y)] ++ constróiArestasAPartirDosVértices (y:t) 

comumEntreDuasListas [] a = []
comumEntreDuasListas a [] = a
comumEntreDuasListas (a:x) (b:y)
    | elem a (b:y) = a: comumEntreDuasListas x (b:y)
    | otherwise = comumEntreDuasListas x (b:y)

geraTuplas numero = ([(x, y)| x <- [1..numero], y <- [x..numero]])

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

éTrilhaEuleriana grafo t = (éTrilha grafo t) && (foldr (&&) True trilha) && (length(trilha) == length (arestas grafo))
    where
        trilha = [adjacente grafo x y | (x, y) <- (constróiArestasAPartirDosVértices t)]

éGrafoEuleriano grafo = resultado
    where
        resultado = foldr (&&) True [even x | x <- seqGraus grafo]

éSemiEuleriano grafo = quantidadeImpares (seqGraus grafo) == 2

éHamiltonianoDirac grafo = quantidadeVértices >= 3 && grau
    where
        quantidadeVértices = length(vértices grafo)
        grau = foldr (&&) True [length(vizinhos grafo v) >= (div quantidadeVértices 2) | v <- vértices grafo]
