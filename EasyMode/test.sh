#!/bin/bash

read -p "test? " ISYES
#echo " $ISYES is yes?"
echo "VPNIP=$ISYES" > /tmp/vpnip.txt
#sudo bash -c "echo VPINIP=$ISYES > test.txt"
#$(sudo echo $ISYES) > test.txt"
#echo $ISYES
