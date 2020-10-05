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
			/_/   /_/  /_/_/ /_/\__/_____/\__,_/_.___/  .00002 Alpha Release
                                           
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

sudo curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

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
echo "Installing WireGuard"
sudo add-apt-repository -y ppa:wireguard/wireguard
sudo apt-get update
sudo apt-get install -y wireguard

# Remove dnsmasq because it will run inside the container.
sudo apt-get remove -y dnsmasq

# Disable systemd-resolved if it blocks port 53.
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved

# Set DNS server.
sudo sh -c "echo nameserver 1.1.1.1 >/etc/resolv.conf"

# Load modules.
sudo modprobe wireguard
sudo modprobe iptable_nat
sudo modprobe ip6table_nat

# Enable modules when rebooting.
sudo sh -c "echo "wireguard" > /etc/modules-load.d/wireguard.conf"
sudo sh -c "echo "iptable_nat" > /etc/modules-load.d/iptable_nat.conf"
sudo sh -c "echo "ip6table_nat" > /etc/modules-load.d/ip6table_nat.conf"

#Creating wg0.conf
sudo bash -c "cd /etc/wireguard; umask 077; wg genkey | tee privatekey | wg pubkey > publickey; echo [Interface] >> /etc/wireguard/wg0.conf; echo Address = 10.38.20.1/24 >> /etc/wireguard/wg0.conf;
echo ListenPort = 51928 >> /etc/wireguard/wg0.conf"

sudo bash -c "echo privkey is $(sudo cat /etc/wireguard/privatekey); echo PrivateKey = $(sudo cat /etc/wireguard/privatekey) >> /etc/wireguard/wg0.conf"
sudo systemctl enable wg-quick@wg0
sudo systemctl start wg-quick@wg0

# Check if systemd-modules-load service is active.
#sudo systemctl status systemd-modules-load.service

# Enable IP forwarding.
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv6.conf.all.forwarding=1

echo ""

echo "Installing PrintLab alpha 2"
cd /usr/local
echo "Cloning PrintLab"
sudo git clone http://github.com/pushc6/PrintLab.git
cd PrintLab
sudo git checkout dev
sudo git pull -r

sudo su - dockeruser -c "docker-compose up -d"

echo ""

cat << "EOF"
    ____  ____  _   __________
   / __ \/ __ \/ | / / ____/ /
  / / / / / / /  |/ / __/ / / 
 / /_/ / /_/ / /|  / /___/_/  
/_____/\____/_/ |_/_____(_)   
EOF
                              

echo "To access your QR code please point a web browser to: http://piaddress:8088 and scan the QRCode with the wireguard client." 
