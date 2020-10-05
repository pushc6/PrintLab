#!/bin/bash

read -p "test? " ISYES
echo " $ISYES is yes?"
sudo bash -c "echo VPINIP=$ISYES > test.txt"
#$(sudo echo $ISYES) > test.txt"
sudo echo $ISYES
