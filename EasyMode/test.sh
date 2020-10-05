#!/bin/bash

TEST=hostname --all-ip-addresses | awk '{print $1}'

echo $TEST

