#!/bin/bash

sudo bash -c "read -p 'test? ' ISYES; $(sudo echo $ISYES) > test.txt"
