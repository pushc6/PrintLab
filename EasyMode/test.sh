#!/bin/bash

sudo su - dockeruser -c "read -p 'test? ' ISYES; echo $ISYES > test.txt"
