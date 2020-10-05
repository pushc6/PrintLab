#!/bin/bash

HTTPHOST=hostname -I | awk '{print $1}'z

echo hostname -I | awk '{print $1}'

echo $HTTPHOST
