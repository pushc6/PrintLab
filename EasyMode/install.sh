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
add-apt-repository -y ppa:wireguard/wireguard
apt-get update
apt-get install -y wireguard

# Remove dnsmasq because it will run inside the container.
apt-get remove -y dnsmasq

# Disable systemd-resolved if it blocks port 53.
systemctl disable systemd-resolved
systemctl stop systemd-resolved

# Set DNS server.
echo nameserver 1.1.1.1 >/etc/resolv.conf

# Load modules.
modprobe wireguard
modprobe iptable_nat
modprobe ip6table_nat

# Enable modules when rebooting.
echo "wireguard" > /etc/modules-load.d/wireguard.conf
echo "iptable_nat" > /etc/modules-load.d/iptable_nat.conf
echo "ip6table_nat" > /etc/modules-load.d/ip6table_nat.conf

# Check if systemd-modules-load service is active.
systemctl status systemd-modules-load.service

# Enable IP forwarding.
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1

echo ""

echo "Installing PrintLab alpha 2"
cd /usr/local
echo "Cloning PrintLab"
sudo git clone http://github.com/pushc6/PrintLab.git
sudo git checkout dev
sudo git pull -r
cd PrintLab

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
