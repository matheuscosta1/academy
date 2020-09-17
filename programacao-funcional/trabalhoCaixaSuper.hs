--Matheus José da Costa
--11711BCC008

-- Simulacao de Filas ---------------------------------------------------------
-- executar: simule (estadoInicialDoServidor 4) entradaDaSimulacao
-- Tipos de Clientes ----------------------------------------------------------

--Questõs discursivas:	
--1) 221
--2) 5
--3) round_robbin :: ClienteQChega -> EstadoDoServidor-> EstadoDoServidor
--   round_robbin im estServ = ult : (take tam estServ)
--    where 
--     tam = (tamanhoDoServidor estServ) -1
--     ult = adicionaCliente im (estServ!!tam)	
--4) nao feito

type Tempo = Int
type TempoQChegou = Int
type TempoPAtend = Int
type TempoDEsp = Int
type TempoDeAtend = Int

data ClienteQChega = Nao | Sim TempoQChegou TempoPAtend
   deriving(Show, Eq)

data ClienteQSai = Nenhum |Liberado TempoQChegou TempoDEsp TempoPAtend
   deriving(Show, Eq)

-- Estado da Fila -------------------------------------------------------------

type EstadoDaFila = (Tempo,TempoDeAtend,[ClienteQChega])

adicionaCliente :: ClienteQChega -> EstadoDaFila -> EstadoDaFila
adicionaCliente m (tempo,tempDeAtend,ml) = (tempo,tempDeAtend, ml++[m])

processaFila :: EstadoDaFila -> (EstadoDaFila, [ClienteQSai])
processaFila (tempo,tempDeAtend,[]) = ((tempo+1,tempDeAtend,[]),[])
processaFila (tempo,tempDeAtend,(Sim a tempNecDAtend:resto))
       | tempDeAtend < tempNecDAtend = (((tempo+1),(tempDeAtend+1),(Sim a tempNecDAtend:resto)),[])
       | otherwise = ((tempo+1,0,resto), [Liberado a (tempo-tempNecDAtend-a) tempNecDAtend])

filaDeInicio :: EstadoDaFila
filaDeInicio = (0,0,[])

tamanhoDaFila :: EstadoDaFila -> Int
tamanhoDaFila (tempo,tempoDeAtend,l) = length l

filaVazia :: EstadoDaFila -> Bool
filaVazia (t,s,q) = (q == [])

-- Estado do Servidor ---------------------------------------------------------

type EstadoDoServidor = [EstadoDaFila]

colocaNaFila :: Int -> ClienteQChega -> EstadoDoServidor -> EstadoDoServidor
colocaNaFila n im st = take n st ++ [novoEstadoDaFila] ++ drop (n+1) st
                       where novoEstadoDaFila = adicionaCliente im (st!!n)

processaServidor :: EstadoDoServidor -> (EstadoDoServidor, [ClienteQSai])
processaServidor [] = ([],[])
processaServidor (q:qs) = ((nq:nqs), mess ++ messes)
                          where (nq,mess) = processaFila q
                                (nqs,messes) = processaServidor qs

processaSimulacao :: EstadoDoServidor -> ClienteQChega -> (EstadoDoServidor,[ClienteQSai])
processaSimulacao estServ im = (adicionaNovoObjeto im estServ1,clientQSai)
                               where (estServ1,clientQSai) = processaServidor estServ

adicionaNovoObjeto :: ClienteQChega -> EstadoDoServidor -> EstadoDoServidor
adicionaNovoObjeto Nao estServ = estServ
adicionaNovoObjeto (Sim tempoDeChegada tempoNecAtend) estServ = colocaNaFila (menorFila estServ) (Sim tempoDeChegada tempoNecAtend) estServ
--adicionaNovoObjeto (Sim tempoDeChegada tempoNecAtend) estServ = round_robbin (Sim tempoDeChegada tempoNecAtend) estServ

estadoInicialDoServidor :: Int -> EstadoDoServidor
estadoInicialDoServidor n
                        |(n == 0) = []
                        |otherwise = (estadoInicialDoServidor (n-1)) ++ [filaDeInicio]

tamanhoDoServidor :: EstadoDoServidor -> Int
tamanhoDoServidor = length

menorFila :: EstadoDoServidor -> Int
menorFila [q] = 0
menorFila (q:qs)
           | tamanhoDaFila (qs!!menor) <= tamanhoDaFila q = menor + 1
           | otherwise = 0
           where menor = menorFila qs
		   
round_robbin :: ClienteQChega -> EstadoDoServidor-> EstadoDoServidor
round_robbin im estServ = ult : (take tam estServ)
                       where 
                        tam = (tamanhoDoServidor estServ) -1
                        ult = adicionaCliente im (estServ!!tam)		   

-- Geracao de Numeros Aleatorios ----------------------------------------------
semente :: Integer
semente = 17489

multiplicador :: Integer
multiplicador = 25173

incremento :: Integer
incremento = 13849

modulo :: Integer
modulo = 65536

dist :: Num t => [(t, Float)]
dist = [(1, 0.2), (2, 0.25), (3, 0.25), (4, 0.15), (5, 0.1), (6, 0.05)]

proxNumAleat :: Integer -> Integer
proxNumAleat n = ((multiplicador*n) + incremento) `rem` modulo

seqAleatoria :: (Integer -> [Integer])
seqAleatoria = iterate proxNumAleat

geraFuncao :: [(t,Float)] -> (Float -> t)
geraFuncao dist = geraFun dist 0.0
geraFun ((ob,p):dist) nUlt aleat
          | nProx >= aleat && aleat > nUlt = ob
          | otherwise = geraFun dist nProx aleat
                       where nProx = (p * (fromInteger modulo)) + nUlt

-- Simulacao ------------------------------------------------------------------

simule :: EstadoDoServidor -> ([ClienteQChega] -> [ClienteQSai])
simule estDoServ (im:messes) = outmesses ++ simule proxEstDoServ messes
                               where (proxEstDoServ,outmesses) = processaSimulacao estDoServ im

seqDeTempos :: [TempoPAtend]
seqDeTempos = map (geraFuncao dist.fromInteger) (seqAleatoria semente)

entradaDaSimulacao :: [ClienteQChega]
entradaDaSimulacao = zipWith Sim [ 1..] seqDeTempos

entradaDaSimulacao2 :: [ClienteQChega]
entradaDaSimulacao2 = take 50 entradaDaSimulacao ++ naos

naos :: [ClienteQChega]
naos = (Nao:naos)

tempoDeEsperaTotal :: ([ClienteQSai] -> Int)
tempoDeEsperaTotal = sum . map tempoDEsp
                     where tempoDEsp (Liberado _ w _) = w