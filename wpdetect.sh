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
WHATIFOUND=""

####################
# Begin tests
####################

# Check for presence of /wp-login.php
####################

HTTPSTATUSCODE=$(curl -L --write-out %{http_code} --silent --output /dev/null $1/wp-login.php)
if [[ $HTTPSTATUSCODE = "200" ]]; then
  ISITWORDPRESS=1
  WHATIFOUND="$WHATIFOUND I found /wp-login.php."
fi

# Check for presence of /wp-content directory
####################
curl -L --silent $1 | grep -q 'wp-content'
if [[ "$?" -ne 1 ]]; then
  ISITWORDPRESS=1
  WHATIFOUND="$WHATIFOUND I found the /wp-content directory."
fi

####################
# Well? Is it WordPress?
####################

if [[ $ISITWORDPRESS = 0 ]]; then
  echo -e "[\033[31m$1\e[0m] is probably not on WordPress"
elif [[ $ISITWORDPRESS = 1 ]]; then
  echo -e "[\033[32m$1\e[0m] is likely on WordPress"
  echo $WHATIFOUND
else
  echo $ISITWORDPRESS - This should not have happened.
fi
