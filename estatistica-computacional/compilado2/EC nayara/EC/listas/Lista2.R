#GRUPO
# Nayara Terezinha Nunes -11911BCC006
# Thaynara Silva Pinto - 11711BCC039
# Victor Hugo Marra Araujo - 11721BCC041
# Gabriel Teodoro Ribeiro - 11911BCC013
# Lucas Marçal Coutinho - 11911BCC012

# 1 
# a 
vetA <- 1:20

# b
vetB <- 20:1

# c
vetC <- c(1:20, 19:1) 

# d
exp1 <- seq(3, 36, 3)
exp2 <- seq(1, 34, 3)
vetD <- (0.1^exp1) * (0.2^exp2)

# e
vetE <- rep(c(4, 6, 3),10)

# f
vetF <- c(vetE,4)

# 2
a <- seq(3, 6, 0.1)
vetG <- exp(a)*cos(a)

# 3 
# a
b <- 10:100
vetH <- sum(b^3 + (4*(b^2)))

# b
d <- 10:25
vetI <- sum(((2^d)/d) + ((3^d)/(d^2)))

# 4
xVec <- sample(0:999, 250, replace=T)
yVec <- sample(0:999, 250, replace=T)

# a
vetJ <- c()
for (e in xVec) {
  if (e %% 2 != 0) 
    vetJ <- c(vetJ, e)
}
vetJ

# b 
vetK <- c()
for (f in 1:249) {
  vetK <- c(vetK, yVec[f+1] - xVec[f])
}
vetK

# c
vetL <- c()
 for (g in 1:249) {
   vetL <- c(vetL, sin(yVec[g+1]) / cos(xVec[g]))
 }
vetL

# d
vetM <- c()
for (h in 1:248) {
  vetM <- c (vetM, xVec[h] + (2*xVec[h+1]) - xVec[h+2])
}
vetM

# e
vetN <- c()
for (i in 1:249) {
  vetN <- c(vetN, (exp(- xVec[i] + 1)) / (xVec[i] + 10))
}
sum(vetN)

# 5 
# a
vetO <- which(yVec > 600)

# b
vetP <- yVec[vetO]

# c
vetQ <- xVec[vetO]

# d
vetR <- (abs(xVec - mean(xVec)))^(1/2)

# e
dist <- sort(yVec, decreasing = TRUE)
for (j in 1:250) {
  if (dist[j] < (max(yVec)-200)){
    size = j-1
    break
  }
}
size

# f
vetS <- c(0)
for (k in xVec) {
  if (k %%2 == 0) {
    vetS <- c(vetS + 1)
  }
}
vetS

# g
yvec_sort <- sort(yVec);
xvec_sort <- c();
for (l in 1:250) {
  pos <- match(yvec_sort[l],yVec);
  xvec_sort <- c(xvec_sort, xVec[pos]);
} 
xvec_sort

# h
vetT <- c()
seqN <- seq(1, 250, by = 3)
for (m in seqN) {
  vetT <- c(vetT, yVec[m])
}
vetT

# 6
resultado <- cumprod(c(1, seq(2, 38, 2))/c(1, seq(3, 39, 2)))

# 7 
library(dslabs)
data(murders)

media <- mean(murders$population)
min = min(murders$population)
minState <- murders$state == min
max <- max(murders$population.state)


