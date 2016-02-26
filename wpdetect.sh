#!/bin/bash
# Version: 0.1.0
# Last Update: February 26, 2016
#
# Description: Bash script to determine if the given URL is on WordPress

####################
# Usage
####################
# bash wpdetect.sh example.com

####################
# Set variables
####################
# set -xv
URLTOTEST=$1
ISITWORDPRESS=0
# curl -v --silent {$1}/readme.html 2>&1 | grep "WordPress"

####################
# Begin tests
####################

# Check for presence of /wp-login.php
####################
HTTPSTATUSCODE=$(curl -L --write-out %{http_code} --silent --output /dev/null {$1}/wp-login.php)
if [ $HTTPSTATUSCODE = "200" ]; then
  ISITWORDPRESS=1
fi

####################
# Well? Is it WordPress?
####################

if [[ $ISITWORDPRESS = 0 ]]; then
  echo -e "[\033[31m$1\e[0m] is probably not on WordPress"
elif [[ $ISITWORDPRESS = 1 ]]; then
  echo -e "[\033[32m$1\e[0m] is likely on WordPress"
else
  echo $ISITWORDPRESS
fi
