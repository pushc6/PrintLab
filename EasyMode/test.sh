#!/bin/bash

test -f /var/lib/dpkg/lock-frontend; then
   echo "file exists"
else
  echo "file doesn't exist"
fi
