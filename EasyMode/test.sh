#!/bin/bash

sudo su - dockeruser -c "read -p 'test? ' ISYES; sudo echo $ISYES > test.txt"
