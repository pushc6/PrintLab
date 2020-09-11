#!/bin/bash
cat << "EOF"
                               , ----.
                              -  -     `
                        ,__.,'           \
                      .'                 *`
                     /       |   |     / **\
                    .                 / ****.
                    |    mm           | ****|
                     \                | ****|
                      ` ._______      \ ****/
                               \      /`---'
                                 \___(
                                 /~~~~\
                                /      \
                               /      | \
                              |       |  \
                    , ~~ .    |, ~~ . |  |\
                   ( |||| )   ( |||| )(,,,)`
                  ( |||||| )-( |||||| )    | ^
                  ( |||||| ) ( |||||| )    |'/
                  ( |||||| )-( |||||| )___,'-
                   ( |||| )   ( |||| )
                    ` ~~ '     ` ~~ '
			    ____             __   _                
			   / __ \__  _______/ /_ ( )_____          
			  / /_/ / / / / ___/ __ \|// ___/          
			 / ____/ /_/ (__  ) / / / (__  )           
			/_/ ___\__,_/____/_/ /_/_/____/        __  
			   / __ \_____(_)___  / /_/ /   ____ _/ /_ 
			  / /_/ / ___/ / __ \/ __/ /   / __ `/ __ \
			 / ____/ /  / / / / / /_/ /___/ /_/ / /_/ /
			/_/   /_/  /_/_/ /_/\__/_____/\__,_/_.___/  .00001 Alpha Release
                                           
EOF


echo "Updating apt repo" 

sudo apt-get update && sudo apt-get upgrade -y

echo "Finished updating apt"

echo""
echo "Creating dockeruser"
sudo useradd dockeruser

echo ""
echo "Installing docker-ce"

#curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh get-docker.sh
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

sudo usermod -aG docker dockeruser

echo "Finished installing docker"

echo ""
echo "Installing git"
sudo apt-get install git -y

echo ""
echo "Installing docker-compose"
sudo apt-get install docker-compose -y

echo "Installing PrintLab alpha 1"
cd /usr/local
sudo git clone http://github.com/pushc6/PrintLab.git
cd PrintLab

sudo su - dockeruser -c "docker-compose up -d"


cat << "EOF"
    ____  ____  _   __________
   / __ \/ __ \/ | / / ____/ /
  / / / / / / /  |/ / __/ / / 
 / /_/ / /_/ / /|  / /___/_/  
/_____/\____/_/ |_/_____(_)   

EOF
                              

ipaddy = hostname -I
echo "To access your QR code please point a web browser to: http://$ipaddy:8088 and scan the QRCode with the wireguard client." 
