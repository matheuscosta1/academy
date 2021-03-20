import GrafoListAdj
import Data.List

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

geraTuplas numero = ([(x, y)| x <- [1..numero], y <- [x..numero]])

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

comumEntreDuasListas [] a = []
comumEntreDuasListas a [] = a
comumEntreDuasListas (a:x) (b:y)
    | elem a (b:y) = a: comumEntreDuasListas x (b:y)
    | otherwise = comumEntreDuasListas x (b:y)

interseção grafoH grafoG = resultado 
    where
       verticesComuns = (comumEntreDuasListas (vértices grafoH) (vértices grafoG))
       arestasComuns = (comumEntreDuasListas (arestas grafoH) (arestas grafoG))
       resultado = novoGrafo (length (verticesComuns)) (arestasComuns)

--soma grafoH grafoG = resultado
    --where
       --resultado = (união (grafoH grafoG))
       --numeroVertices = length((vértices(resultado)))
       --final = (novoGrafo (numeroVertices (semTuplasIguais(geraTuplas numeroVertices))))

-- removeVértices grafo listaVértices = resultado
    -- where
       -- ajustaGrafo = ((map (removeVértice grafo) (removeRepetidos (vértices grafo) listaVértices)))
       -- resultado = ajustaGrafo

