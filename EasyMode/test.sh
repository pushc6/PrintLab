#!/bin/bash

sudo bash -c "read -p 'test? ' ISYES; echo \" $ISYES is yes?\"; $(sudo echo $ISYES) > test.txt"
