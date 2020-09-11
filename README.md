# PrintLab
All you need to securely access your printer from the outside world, along with other useful utilities for 3d printing.

# Install instructions

First, setup port forwarding of UDP port 51820 to your pi's IP address. Giving your PI a static ip is recommended but not strictly necessary. However if your pi's ip ever changes you will need to redo this port forwarding.


## Easy mode install
If you have a fresh install on your Pi and want the minimal muss and fuss this is for you. This will download and install everything you need to get the PrintLab up and running. 

1. Copy contents of install.sh in the EasyMode folder of this repository. 
2. ssh into your pi via ssh pi@piaddress
3. nano /tmp/install.sh
4. Paste contents of install.sh into this new file.
5. hit ctrl + x when prompted to save, press 'y' for yes.
6. chmod 777 /tmp/install.sh
7. /tmp/install.sh
8. Profit.

After the script finishes everything should be installed and running. Point your browser to http://piaddress:9453 to get your WireGuard QRCode.

## Familiar with docker-compose install

If you are familiar with docker-compose you can clone this repo and run "docker-compose up -d" and it will do the same thing as the above. The script above assumes you have nothing pre-configured.

## Configuration
If you use the "easy-mode" install you probably don't need to configure anything, it should just work. If you *do* need to configure something most everything is located in the docker-compose.yml file, minus the nginx config which has it's own folder. 

## What's installed?
PrintLab contains several images that help make installation\management easier. If you are a power user you don't need to install nginx or portainer if you don't want, you can just remove them from the docker-compose.yaml. But if you are a power user, you probably wouldn't be using this image anyway (yet).

### Wireguard
This is the main reason for this repo. It allows for easy and secure access to your printer while at home via apps like Octopod.

### Nginx
This is used to provide easy access to the QR code necessary to configure the wireguard client. It is always online so you can quick reference it

### Portainer
If you want to make changes or view the status of your services this has been installed to make that easier for non-power users. 

