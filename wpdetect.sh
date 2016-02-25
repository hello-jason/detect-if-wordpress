#!/bin/bash
# Version: 0.1.0
# Last Update: February 25, 2016
#
# Description: Bash script to determine if the given URL is on WordPress

####################
# Usage
####################
# bash wpdetect.sh example.com

####################
# Set variables
####################
URLTOTEST=$1

curl -v --silent {$1}/readme.html 2>&1 | grep "WordPress"
