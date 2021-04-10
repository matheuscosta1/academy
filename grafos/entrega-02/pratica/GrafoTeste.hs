import Grafo
import GrafoListAdj

-- Testes

g1 = novoGrafo 1 []

g2 = novoGrafo 1 [(1,1)]

g3 = novoGrafo 2 [(1,1), (1,2)]

g4 = novoGrafo 0 []

g5 = novoGrafo 1 [(1,2)]

g6 = novoGrafo 2 [(1,1), (1,2), (2,3), (4,5)]

g7 = novoGrafo 3 [(1,2),(1,3),(2,3),(2,1),(3,1),(3,2)]

g8 = novoGrafo 3 [(1,2),(1,3),(2,3),(2,1),(3,1),(3,1)]

g9 = novoGrafo 4 [(1,2),(1,3),(1,4),(2,1),(2,3),(2,4),(3,1),(3,2),(3,4),(4,1),(4,2),(4,3)]

g10 = novoGrafo 3 [(1,2),(1,3),(2,3)]

g11 = novoGrafo 4 [(1,2),(1,3),(2,3),(3,4)]

g12 = novoGrafo 3 [(1,2), (1,3), (2,3)]

-- Exemplos de uso

-- > éTrivial g1
--  True

-- > éTrivial g2
--  False

-- > éTrivial g3
--  False

-- > éVazio g1
--  True

-- > éVazio g2
--  False

-- > éVazio g3
--  False

-- > éIsolado g1 1
--  True

-- > éIsolado g2 1
--  False

-- > éIsolado g3 2
--  False

-- > éNulo g4
--  True

-- > éNulo g1 1
--  False

-- > éNulo g3 2
--  False

-- > éTerminal g5 1
--  True

-- > éTerminal g2 1
--  False

-- > éTerminal g3 1
--  False

-- > éPar g1 1
--  True

-- > éPar g2 1
--  True

-- > éPar g3 1
--  False

-- > éImpar g1 1
--  False

-- > éImpar g2 1
--  False

-- > éImpar g3 1
--  True

-- > seqGraus g3
--  [1,3]

-- > seqGraus g6
--  [1,1,1,2,3]

-- > grauMax g3
--  3

-- > grauMax g5
--  1

-- > grauMin g6
--  1

-- > grauMin g1
--  0

-- > grauMin g2
--  2

-- > éRegular g7
--  True

-- > éRegular g8
--  False

-- > éRegular g9
--  True

-- > éKRegular g10
--  True

-- > éKRegular g9
--  False

-- > éKRegular g1
--  True

-- > éCompleto g9
--  True

-- > éCompleto g1
--  True

-- > éCompleto g2
--  False

-- > éKn g9 4
--  True

-- > éKn g9 1
--  False

-- > éKn g10 3
--  True

-- > grafoCompleto 2
--  LsAdj (fromList [(1,[2]),(2,[1])])

-- > grafoCompleto 3
--  LsAdj (fromList [(1,[3,2]),(2,[3,1]),(3,[2,1])])

-- > grafoCompleto 5
--  LsAdj (fromList [(1,[5,4,3,2]),(2,[5,4,3,1]),(3,[5,4,2,1]),(4,[5,3,2,1]),(5,[4,3,2,1])])

-- > grafoComplemento g10
--  LsAdj (fromList [(1,[]),(2,[]),(3,[])])

-- > grafoComplemento g2
--  LsAdj (fromList [(1,[])])

-- > grafoComplemento g9
--  LsAdj (fromList [(1,[]),(2,[]),(3,[]),(4,[])])

-- > éSubgrafo g5 g6
--  True

-- > éSubgrafo g1 g2
--  True

-- > éSubgrafo g2 g1
--  False

-- > éSubgrafoPróprio g2 g3
--  True

-- > éSubgrafoPróprio g3 g2
--  False

-- > éSubgrafoPróprio g1 g2
--  True

-- > éSubgrafoInduzidoVértices g12 g11 [1,2,3]
--  True

-- > éSubgrafoInduzidoVértices g1 g12 [1,2,3]
--  False

-- > éSubgrafoInduzidoVértices g6 g7 [1,2,3]
--  False

-- > éSubgrafoInduzidoArestas g12 g11 [(1,2)]
--  True

-- > éSubgrafoInduzidoArestas g12 g11 [(1,2)]
--  False

-- > éSubgrafoInduzidoArestas g12 g11 [(1,2),(1,3),(2,3)]
--  True

-- > éClique g11 g12
--  False

-- > éClique g12 g11
--  True

-- > éClique g6 g7
--  False

-- > éCjIndependenteVértices g1 g2
--  True

-- > éCjIndependenteVértices g2 g1
--  False

-- > éCjIndependenteVértices g5 g6
--  False

-- > união g1 g2
--  LsAdj (fromList [(1,[1,1])])

-- > união g6 g7
--  LsAdj (fromList [(1,[1,1,3,2]),(2,[1,3]),(3,[1,2]),(4,[5]),(5,[4])])

-- > união g2 g3
--  LsAdj (fromList [(1,[2,1,1]),(2,[1])])

-- > interseção g5 g6
--  LsAdj (fromList [(1,[2]),(2,[1])])

-- > interseção g6 g7
--  LsAdj (fromList [(1,[2]),(2,[1,3]),(3,[2])])

-- > interseção g10 g11
--  LsAdj (fromList [(1,[3,2]),(2,[1,3]),(3,[1,2])])



