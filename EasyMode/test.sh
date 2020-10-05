#!/bin/bash

HTTPHOST=$(hostname | awk '{print $1}')

echo $HTTPHOST
