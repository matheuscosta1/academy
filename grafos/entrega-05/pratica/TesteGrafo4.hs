import Grafo4
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

g13 = novoGrafo 4 [(1,2), (1,3), (1,4), (3,4)]

g14 = novoGrafo 5 [(1,3), (1,4), (1,5), (2,3), (2,4), (2,5)]

g15 = novoGrafo 5 [(1,3), (1,2), (1,4), (1,5), (2,3), (2,4), (2,5)]

g16 = novoGrafo 4 [(1,2), (1,3), (1,4), (2,3), (2,4), (3,4)]

g17 = novoGrafo 7 [(1,2), (1,7), (2,3), (2,6), (2,7), (3,4), (3,5), (3,6), (4,5), (5,6), (5,7), (6,7)]

g18 = novoGrafo 6 [(1,2), (1,5), (1,6), (2,3), (2,4), (2,6), (3,4), (4,5), (4,6), (5,6)]

g19 = novoGrafo 6 [(1,2), (1,3), (1,6), (2,3), (2,4), (3,5), (4,5), (4,6), (5,6)]

g20 = novoGrafo 4 [(0,1),(1,3),(3,2),(3,4)]

g21 = novoGrafo 4 [(1,2),(2,3),(3,4)]

g22 = novoGrafo 4 [(1,2), (1,3), (1,4), (3,4)]

g23 = novoGrafo 4 [(0,1),(1,2),(2,3)]

g24 = novoGrafo 5 [(1,2),(1,0),(2,0),(0,3),(3,4)]

g25 = novoGrafo 2 [(0,1)]

g26 = novoGrafo 4 [(1,2),(1,3),(1,4)]

g27 = novoGrafo 9 [(1,2),(1,3),(2,4),(3,5),(3,6),(4,7),(5,8),(5,9)]

g28 = novoGrafo 6 [(1,4),(2,4),(3,4),(4,5),(5,6)]

g29 = novoGrafo 15 [(1,4),(1,6),(1,2),(1,10),(6,11),(6,12),(4,5),(5,9),(5,8),(2,3),(3,7),(7,15),(7,14),(7,13)]

g30 = novoGrafo 5 [(1,3),(3,2),(3,4),(3,5)]

g31 = novoGrafo 7 [(1,2),(1,3),(2,4),(2,5),(3,6),(3,7)]

g32 = novoGrafo 8 [(1,2),(1,3),(2,4),(2,5),(3,6),(3,7),(4,8)]

g33 = novoGrafo 11 [(1,2),(1,3),(2,4),(2,5),(3,6),(3,7),(7,8),(8,9),(9,10),(10,11)]

g34 = novoGrafo 11 [(1,2),(1,3),(2,4),(2,5),(3,6),(3,7),(7,8),(7,9),(7,10)]

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

--  3

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

-- > fundeVértices g13 2 3
--  LsAdj (fromList [(1,[4,2,2]),(2,[1,4,1]),(4,[1,2])])

-- > fundeVértices g13 1 2
--  LsAdj (fromList [(1,[4,3,1,1]),(3,[1,4]),(4,[1,3])])

-- > fundeVértices g13 3 4
--  LsAdj (fromList [(1,[3,2,3]),(2,[1]),(3,[1,3,3,1])])

-- > contraiVértices g13  4
--  LsAdj (fromList [(1,[4,2,1,1]),(2,[1]),(4,[1])])

-- > contraiVértices g10 1 2
--  LsAdj (fromList [(1,[3,1,1]),(3,[1])])

-- > contraiVértices g8 1 3
--  LsAdj (fromList [(1,[2,1,1]),(2,[1])])

-- > contraiAresta g8 (1,3)
--  LsAdj (fromList [(1,[2]),(2,[1])])

-- > contraiAresta g10 (1,2)
--  LsAdj (fromList [(1,[3]),(2,[]),(3,[1])])

-- > contraiAresta g8 (1,3)
--  LsAdj (fromList [(1,[2]),(2,[1])])

-- > éPasseio g14 [1,3,2,5]
--  True

-- > éPasseio g15 [1,2,3]
--  True

-- > éPasseio g15 [1,2,3,5]
--  False

-- > éPasseioAberto g14 [1,2,3,5]
--  True

-- > éPasseioAberto g14 [1,3,5]
--  False

-- > éPasseioAberto g15 [1,3,2,5]
--  True

-- > éPasseioFechado g15 [1,3,2,5]
--  False

-- > éPasseioFechado g10 [1,3,2,1]
--  True

-- > éPasseioFechado g10 [1,2,2,1]
--  False

-- > éTrilha g10 [1,2,3,1]
--  True

-- > éTrilha g10 [1,2,1,3]
--  False

-- > éTrilha g15 [1,2,3]
--  True

-- > éCaminho g10 [1,2,3,1]
--False

-- > éCaminho g3 [1,2,1]
--False

-- > éCaminho g5 [1,3,2]
--True

-- > éCiclo g10 [1,2,1]
--True

-- > éCiclo g10 [1,2,3,1]
--True

-- > éCiclo g10 [1,3,2]
--False

-- > éCiclo g10 [1,3,2]
--False

-- > éGrafoCíclico g10
--True

-- > éGrafoCíclico g13
--False

-- > éGrafoCíclico g14
--False

-- > éCn g10 3
--True

-- > éCn g10 2
--False

-- > éCn g13 3
--False

-- > éGrafoCaminho g16
--True

-- > éGrafoCaminho g10
--True

-- > éGrafoCaminho g15
--False

-- > éGrafoCaminho g16 4
--True

-- > éGrafoCaminho g10 3
--True

-- > éGrafoCaminho g10 2
--False

-- > éGrafoBipartido g14 [1,3] [3,4,5]
--True

-- > éGrafoBipartido g16 [1,3] [3,4,5]
--False

-- > éGrafoBipartido g14 [1,2] [3,4]
--False

-- > éTrilhaEuleriana g17 [1,2,3,4,5,7,2,6,3,5,6,7,1]
--True

-- > éTrilhaEuleriana g14 [1,2,3]
--False

-- > éTrilhaEuleriana g17 [1,2,3,4,5,7,2,6,3,5,6,7]
--False

-- > éGrafoEuleriano g17
--True

-- > éGrafoEuleriano g14
--False

-- > éGrafoEuleriano g9
--True

-- > éSemiEuleriano g9
--False

-- > éSemiEuleriano g18
--True

-- > éSemiEuleriano g14
--True

-- > éHamiltonianoDirac g19
--True

-- > éHamiltonianoDirac g16
--True

-- > éHamiltonianoDirac g18
--False

-- > éConexo g20
--True

-- > éConexo g12
--True

-- > éConexo g1
--False

-- > ciclo g12 [6]
--[1,2,3]

-- > ciclo g12 [3]
--[3,1,2]

-- > ciclo g9 [4]
--[4,1,2,3]

-- > distância g17 1 3
--2

-- > distância g17 1 2
--1

-- > distância g17 3 7
--2

-- > excentricidade g17 3
--2

-- > excentricidade g10 2
--1

-- > excentricidade g18 6
--2

-- > raio g18
--1

-- > raio g17
--1

-- > raio g10
--1

-- > diâmetro g9
--1

-- > diâmetro g17
--1

-- > diâmetro g22
--2

-- > centro g9
--[1,2,3,4]

-- > centro g17
--[1,2,3,4,5,6,7]

-- > centro g22
--[1]

-- > éArticulação g23 1
--True

-- > éArticulação g23 2
--True

-- > éArticulação g23 3
--False

-- > éPonte g24 (0,3)
--True

-- > éPonte g24 (1,2)
--False

-- > éPonte g23 (0,1)
--True

-- > conectividade g20
--3

-- > conectividade g9
--3

-- > conectividade g1
--0

-- > éBiconexo g25
--True

-- > éBiconexo g24
--True

-- > éBiconexo g9
--False

-- > éÁrvore g26
--True

-- > éÁrvore g27
--True

-- > éÁrvore g25
--False

-- > éEstrela g26
--True

-- > éEstrela g27
--False

-- > éEstrela g19
--False

-- > éFloresta g34
--True

-- > éFloresta g31
--False

-- > éFloresta g33
--False

-- > folhas g28
--[1,2,3,6]

-- > folhas g27
--[6,7,8,9]

-- > folhas g26
--[2,3,4]

-- > internos g28
--[4,5]

-- > internos g28
--[4,5]

-- > internos g24
--[0,1,2,3]

-- > centroÁrvore g31
--[1,2,3,4,5,6,7]

-- > centroÁrvore g34
--[1,2,3,4,5,6,7,8,9,10,11]

-- > centroÁrvore g30
--[3]

-- > éAncestral g29 6 1 10
--True

-- > éAncestral g29 7 15 3
--False

-- > éAncestral g29 1 6 3
--False

-- > éDescendente g29 3 1 2
--True

-- > éDescendente g29 4 5 9
--True

-- > éDescendente g29 5 8 9
--False

-- > éIrmão g31 1 4 3
--False

-- > éIrmão g31 1 4 5
--True

-- > éIrmão g31 1 6 7
--True

-- > nível g31 1 5
--2

-- > nível g31 1 4
--2

-- > nível g32 1 2
--1

-- > nivel g32 1
--2

-- > nivel g32 10
--0

-- > nivel g32 5
--1

-- > éÁrvoreBin g32 1
--True

-- > éÁrvoreBin g33 1
--True

-- > éÁrvoreBin g34 1
--False

-- > éÁrvoreBinEstrita g34
--False

-- > éÁrvoreBinEstrita g31
--True

-- > éÁrvoreBinEstrita g32
--False

-- > éÁrvoreM g34 1
--False

-- > éÁrvoreM g32 2
--True

-- > éÁrvoreM g31 2
--True

-- > éÁrvoreMcheia g32 1 2
--False

-- > éÁrvoreMcheia g31 1 2
--True

-- > éÁrvoreMcheia g34 1 2
--False

-- > prufer g31
--[2,2,1,3,3,3]

-- > prufer g34
--[]

-- > prufer g33
--[2,2,1,3,3,7,8,9,10,10]

-- > decodPrufer [2,2,1,3,3,7,8,9,10,10]
--LsAdj (fromList [(1,[3,2]),(2,[1,5,4]),(3,[7,6,1]),(4,[2]),(5,[2]),(6,[3]),(7,[8,3]),(8,[9,7]),(9,[10,8]),(10,[12,11,9]),(11,[10]),(12,[10])])

-- > decodPrufer [2,2,1,3,3,3]
--LsAdj (fromList [(1,[3,2]),(2,[1,5,4]),(3,[8,7,6,1]),(4,[2]),(5,[2]),(6,[3]),(7,[3]),(8,[3])])

-- > decodPrufer []
--LsAdj (fromList [(1,[2]),(2,[1])])

-- > éSeqVálida [3,4,2,1,3,5,5,5]
--False

-- > éSeqVálida [1,1]
--True

-- > éSeqVálida [1,1,1,1,2,3,3]
--True

-- > numÁrvRotuladas [1,1,1,1,2,3,3]
--30

-- > numÁrvRotuladas [1,1,1,1,2]
--6

-- > numÁrvRotuladas [1,1,3,3,4]
--0

