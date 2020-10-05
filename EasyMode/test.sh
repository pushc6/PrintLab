#!/bin/bash
FILE=/var/lib/dpkg/lock-frontend
if [ -f "$FILE" ]; then
   echo "file exists"
else
  echo "file doesn't exist"
fi
