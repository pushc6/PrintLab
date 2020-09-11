#!/bin/bash

echo "Updating apt repo" 

sudo apt-get update && sudo apt-get upgrade -y

echo "Finished updating apt"

echo""
echo "Creating dockeruser"
sudo useradd --system dockeruser

echo ""
echo "Installing docker-ce"

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo usermod -aG docker dockeruser

echo "Finished installing docker"

echo ""
echo "Installing git"
sudo apt-get install git -y

echo ""
echo "Installing docker-compose"
sudo apt-get install docker-compose -y

echo "Installing PrintLab alpha 1"
cd /opt
git clone http://github.com/pushc6/PrintLab.git
cd PrintLab

sudo su - dockeruser -c "docker-compose up -d"

echo "done"
