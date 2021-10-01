module Root.Src.Exercise where
import Graphics.Rendering.OpenGL.GLU.Tessellation (PolygonContours)

{- 
Defina um tipo Ponto que represente um ponto no R2 como uma dupla de números reais.

p1 :: Ponto
p1 = (10.0,11.0)
-}


type Ponto = (Float, Float)

ponto:: Ponto
ponto = (10.0, 11.0)

type Raio = Int

type Circulo = (Float, Float)

data FormaGeo = Círculo Ponto Float | Quadrado Ponto Float | Retângulo Ponto Float Float | Triângulo Ponto Float Float deriving (Eq, Show)

f1 :: FormaGeo
f1 = Círculo ponto 3

f2 :: FormaGeo
f2 = Quadrado ponto 10.0

f3 :: FormaGeo
f3 = Retângulo ponto 3 4

f4 :: FormaGeo
f4 = Triângulo ponto 2.0 3.0
{-
Defina um tipo algébrico FormaGeo que represente as formas geométricas básicas círculo, quadrado, retângulo e triângulo retângulo.
Cada forma deve ser posicionada usando um Ponto e ter suas dimensões fundamentais, por exemplo o raio, para o círculo.

f1 :: FormaGeo
f1 = Círculo p1 3

f2 :: FormaGeo
f2 = Quadrado p1 10.0

f3 :: FormaGeo
f2 = Retângulo p1 3 4

f3 :: FormaGeo
f3 = Triângulo p1 b a
-}

{-
Defina uma função área que tenha como parâmetro formal uma FormaGeo e retorne a área da forma correspondente.
Use Casamento de Padrões.
-}

área :: FormaGeo -> Float
área (Círculo ponto raio) = 3.1415 * raio * raio
área (Quadrado ponto lado) = lado * lado
área (Retângulo ponto altura base) = altura * base
área (Triângulo ponto altura base) = (altura * base) / 2


{-
Defina um tipo algébrico Mão que represente os possíveis valores do jogo Pedra/Tesoura/Papel.
Defina um tipo algébrico Jogo que tenha os valores Empate e Ganha x, onde x é uma Mão.
Defina uma função que receba duas Mão como parâmetros e retorne um Jogo.
- Se uma mão for vencedora, o Jogo deve ser Ganha x, onde x é a mão ganhadora.
- Se houver empate, o Jogo deve ser Empate.


Defina uma função que receba uma lista de tuplas de Mão e retorne uma lista de Jogo com os respectivos resultados.
- Faça uma versão que use recursão sobre listas.
- Faça uma versão que use compreensão de listas.

Defina uma função que receba um lista de Jogo e retorne uma lista com as Mão ganhadoras, dos jogos onde não houve empate.
- Use compreensão de listas.
-}

data Mão = Pedra | Papel | Tesoura deriving (Eq, Show)

data Jogo = Empate | Ganha Mão

quemGanha :: Mão -> Mão -> Jogo
quemGanha Pedra Tesoura = Ganha Pedra
quemGanha Pedra Papel = Ganha Papel
quemGanha Tesoura Papel = Ganha Tesoura
quemGanha Tesoura Pedra = Ganha Pedra
quemGanha Papel Pedra = Ganha Papel
quemGanha Papel Tesoura = Ganha Tesoura
quemGanha _ _ = Empate

quemGanha' :: [(Mão,Mão)] -> [Jogo]
quemGanha' lista = [quemGanha mao1 mao2 | (mao1,mao2) <- lista]

{-
Defina um tipo algébrico Operação com valores que representem as seguintes operações matemáticas básicas:
- Add (adição), Mult (multiplicação), Div (divisão), Dif (diferença) e Neg (negação do sinal).
- As operações tem 2 ou 1 operandos (somente a negação).
- As parâmetros são números inteiros.
Escreva uma função que receba uma operação e retorne o resultado da execução da operação.
- Os resultados são números inteiros (div é a divisão inteira)
- Use casamento de padrões.
-}

data Operação = Add Int Int | Mult Int Int | Div Int Int | Dif Int Int | Neg Int

fazOperação :: Operação -> Int
fazOperação (Add x y) = x + y
fazOperação (Mult x y) = x * y
fazOperação (Div x y) = if y /= 0 then div x y else error "Divisão por zero"
fazOperação (Dif x y) = x - y
fazOperação (Neg x) = negate x


{-
Defina um tipo algébrico Expressão com valores que representem as seguintes operações matemáticas básicas ou, recursivamente, outras expressões.
- Add (adição), Mult (multiplicação), Div (divisão), Dif (diferença) e Neg (negação do sinal).
- As operações tem 2 ou 1 operandos (somente a negação).
- As parâmetros são números inteiros OU outra expressão.
Escreva uma função que receba uma expressão e retorne o cálculo expressão.
- Use recursão e casamento de padrões.
- Os resultados são números inteiros (div é a divisão inteira)

Exemplo: A expressão  -1 * ((3*4) + 1) é representa assim

        EMult
       /     \
    ENeg      EAdd
   /         /     \
ENum   EMult       ENum
  |    /   \         |
  1   ENum  ENum     1
       |     |
       3     4

>>>calculaE (ENum 1)
1

>>>calculaE (ENeg (ENum 1))
-1

>>>calculaE (EMult (ENum 3) (ENum 4))
12

>>>calculaE (EMult (ENeg (ENum 1)) (EAdd (EMult (ENum 3) (ENum 4)) (ENum 1)))
-13
-}

data Expressao = EAdd Expressao Expressao | ENeg Expressao | ENum Int


executaExpressao:: Expressao -> Int
executaExpressao (ENum i) = i
executaExpressao (ENeg e) = negate (executaExpressao e)
executaExpressao (EAdd e1 e2) = executaExpressao e1 + executaExpressao e2


{--
>>> executaExpressao (ENum 3)
Data constructor not in scope: Enum :: Integer -> Expressao

--}
