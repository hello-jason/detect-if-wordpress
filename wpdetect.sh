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
# Make sure the right programs are available
####################

# cURL
####################
curl --version &> /dev/null
if [[ "$?" -ne 0 ]]; then
  echo "cURL is required. Please install it."
  exit 1
fi

# grep
####################
grep --version &> /dev/null
if [[ "$?" -ne 0 ]]; then
  echo "grep is required. Please install it."
  exit 1
fi

####################
# Set variables
####################
# set -xv
URLTOTEST=$1
ISITWORDPRESS=0
WHATIFOUND=""

####################
# Validate the given URL
####################
URLSTATUSCODE=$(curl -L --write-out %{http_code} --silent --output /dev/null $1
if [[ $URLSTATUSCODE != "200" ]]; then
  echo "$1 is unreachable."
  exit 1
fi

####################
# Begin tests
####################

# Check for presence of /wp-login.php
####################

HTTPSTATUSCODE=$(curl -L --write-out %{http_code} --silent --output /dev/null $1/wp-admin)
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

if [[ $ISITWORDPRESS == 0 ]]; then
  echo -e "[\033[31m$1\e[0m] is probably not on WordPress."
elif [[ $ISITWORDPRESS == 1 ]]; then
  echo -e "[\033[32m$1\e[0m] is likely on WordPress.$WHATIFOUND"
else
  echo $ISITWORDPRESS - This should not have happened.
fi
