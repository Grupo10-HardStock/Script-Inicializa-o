#!/bin/bash

echo "Meu primeiro shell script"

# Atualizando o sistema
echo "Atualizando o Linux antes de começarmos"
sudo apt update && sudo apt upgrade -y

# Verificando a versão do Python
echo "Verificando a versão do Python"
python3 --version

if [ $? = 0 ]; then 
    echo "Python instalado"
else 
    echo "Python não instalado"
    echo "Gostaria de instalar o Python? [s/n]"
    read get 
    if [ "$get" == "s" ]; then 
        sudo apt install python3 -y 
    fi 
fi 

# Verificando a versão do Docker
echo "Verificando a versão do Docker"
docker --version
if [ $? = 0 ]; then 
    echo "Docker instalado"
else 
    echo "Docker não instalado"
    echo "Gostaria de instalar o Docker? [s/n]"
    read get 
    if [ "$get" == "s" ]; then 
        sudo apt install -y docker-ce 
    fi 
fi 

# Iniciando o serviço do Docker
sudo systemctl start docker
sudo systemctl enable docker

# Nome da imagem e tag
docker_image="pedrobarbosasouza/imagem_node"
docker_tag="tagname"  # Modifique essa tag conforme necessário

# Pull da imagem Docker
echo "Fazendo o pull da imagem Docker: $docker_image:$docker_tag"
if sudo docker pull "$docker_image:$docker_tag"; then
    echo "Imagem $docker_image:$docker_tag baixada com sucesso"
else
    echo "Erro ao baixar a imagem $docker_image:$docker_tag"
    exit 1
fi

# Executando o container Docker
echo "Rodando a imagem Docker"
if sudo docker run -d --name meu_container -p 3333:3333 "$docker_image:$docker_tag"; then
    echo "Container iniciado com sucesso"
else
    echo "Erro ao iniciar o container"
    exit 1
fi

sudo docker ps -a

# Fazendo o push da imagem Docker
echo "Fazendo o push da imagem Docker: $docker_image:$docker_tag"
if sudo docker push "$docker_image:$docker_tag"; then
    echo "Imagem $docker_image:$docker_tag enviada com sucesso"
else
    echo "Erro ao enviar a imagem $docker_image:$docker_tag"
    exit 1
fi
