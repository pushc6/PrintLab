#!/bin/bash

TEST=`hostname --all-ip-addresses | awk '{print $1}'`

echo "test is $TEST"

