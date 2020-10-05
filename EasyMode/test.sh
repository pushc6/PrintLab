#!/bin/bash

hostname --all-ip-addresses | awk '{print $1}'

