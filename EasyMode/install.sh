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

sudo apt-get update
sudo apt-get upgrade -y

echo "Finished updating apt"

echo""
echo "Creating dockeruser"
sudo useradd dockeruser

echo ""
echo "Installing docker-ce"

#curl -fsSL https://get.docker.com -o get-docker.sh
#sudo sh get-docker.sh
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

echo ""
echo "grabbing gpg keys"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

echo ""
echo "Adding apt repository for Docker"
sudo add-apt-repository \
   "deb [arch=arm64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo ""
echo "Updating apt"
sudo apt-get update

echo ""
echo "Installing docker"
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

echo ""
echo "Adding dockeruser to docker group"
sudo usermod -aG docker dockeruser

echo "Finished installing docker"

echo ""
echo "Installing git"
sudo apt-get install git -y

echo ""
echo "Installing docker-compose"
sudo apt-get install docker-compose -y

echo ""
echo "Installing PrintLab alpha 1"
cd /usr/local
echo "Cloning PrintLab"
sudo git clone http://github.com/pushc6/dev/PrintLab.git
cd PrintLab

sudo su - dockeruser -c "docker-compose up -d"

echo ""
echo "Getting rid of default resolver"
cat << "EOF" > test.txt
[Resolve]
DNS=127.0.0.0
#FallbackDNS=
#Domains=
#LLMNR=no
#MulticastDNS=no
#DNSSEC=no
#DNSOverTLS=no
#Cache=no
DNSStubListener=no
#ReadEtcHosts=yes
EOF

echo ""
echo "Creating symlink to new resolv"
sudo ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf

cat << "EOF"
    ____  ____  _   __________
   / __ \/ __ \/ | / / ____/ /
  / / / / / / /  |/ / __/ / / 
 / /_/ / /_/ / /|  / /___/_/  
/_____/\____/_/ |_/_____(_)   
EOF
                              

echo "To access your QR code please point a web browser to: http://piaddress:8088 and scan the QRCode with the wireguard client." 
