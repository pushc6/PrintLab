#!/bin/bash

HTTPHOST=hostname -I | awk '{print $1}'

echo $HTTPHOST
