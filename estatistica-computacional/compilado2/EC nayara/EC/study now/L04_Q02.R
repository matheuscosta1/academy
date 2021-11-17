# Lista 04 - Exercício 02
# Alunos: Pedro Henrique Resende Ribeiro - 12011BCC004
#         Kemuel Santos Peres  - 11811BCC035
#         Nayara Terezinha Nunes - 11911BCC006

heart_attack = function(dados){
  
  tamanho = length(dados)
  
  if(tamanho != 4){
    return(as.factor("error"))
  }
  
  if(dados[1] == "yes"){
    return(as.factor("yes"))
  }else{
    if(dados[4] == "no"){
      return(as.factor("yes"))
    }else{
      if(dados[2] == "no"){
        return(as.factor("yes"))
      }else{
        if(dados[3] == "yes"){
          return(as.factor("yes"))
        }else{
          return(as.factor("no"))
        }
      }
    }
  }
  
}

dados <- c("no", "yes", "no", "yes")
dados <- as.factor(dados)
dados

decisao = heart_attack(dados)
decisao
