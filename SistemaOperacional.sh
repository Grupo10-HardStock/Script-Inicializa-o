#!/bin/bash

echo "Meu primeiro shell script"

echo "Atualizando o Linux antes de começarmos"
sudo apt update && sudo apt upgrade -y

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

sudo systemctl start docker
sudo systemctl enable docker

docker_image="pedrobarbosasouza/imagem_node:tagname"

echo "Fazendo o pull da imagem Docker: $docker_image"
sudo docker pull $docker_image

echo "Rodando a imagem Docker"
sudo docker run -d --name meu_container -p 3333:3333 $docker_image

sudo docker ps -a

echo "Realizando o push da imagem Docker"
docker push $docker_image
