#!/bin/bash


linuxSetup()
{
    echo $USER - "Linux Setup"
    sudo apt update
    sudo apt install apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt update
    sudo apt install docker-ce
    sudo systemctl status docker
    docker -v
    sudo usermod -aG docker $USER
    curl -L https://github.com/docker/compose/releases/download/1.24.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
    docker-compose --version
    mkdir -p ~/docker-registry
    cp -r docker-compose.yml ~/docker-registry/
    cd ~/docker-registry/
    docker-compose up -d
    sudo apt install nginx
    cp docker /etc/nginx/sites-available/
    sudo ln -s /etc/nginx/sites-available/docker /etc/nginx/sites-enabled/docker
    cp dockerhub /etc/nginx/sites-available/
    sudo ln -s /etc/nginx/sites-available/dockerhub /etc/nginx/sites-enabled/dockerhub
    sudo systemctl reload nginx.service
    echo "------------END------------"
}



# Ask the user for their os
echo welcome, $USER
echo what\'s your operating system?
echo 1. Ubuntu
read os
if [[ $os == "1" || $os == "mac" ]]; then
    macSetup
    elif [[ $os == "2" || $os == "ubuntu" ]]; then
    linuxSetup
else
    echo wrong input!
    
fi

