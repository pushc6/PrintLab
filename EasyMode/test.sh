#!/bin/bash
FILE=/var/lib/dpkg/lock-frontend
if [[ ! -f "$FILE" ]]; then
   echo "file not exist"
else
  echo "file exist"
fi
