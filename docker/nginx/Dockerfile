# Chama a imagem "ubuntu:16.04" como imagem base para o build
# O FROM é obrigatório no início
FROM ubuntu:16.04
 
# Atualizado o repo, instala o NGINX e remove o cache do APT
RUN apt-get update -y && apt-get install nginx -y \
    && rm -rf /var/lib/apt/lists/*
 
# Inicia o NGINX quando o container for executado
CMD ["nginx", "-g", "daemon off;"]
