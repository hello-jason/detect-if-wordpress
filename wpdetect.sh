#!/bin/bash
# Version: 0.1.0
# Last Update: February 26, 2016
#
# Description: Bash script to determine if the given URL is on WordPress
# Author: Jason Cross
# Author URI: https://hellojason.net/
# Repository: https://github.com/hello-jason/detect-if-wordpress

########################################
# Usage
########################################
# bash wpdetect.sh example.com

########################################
# Make sure the right programs are available
########################################

# cURL is required
########################################
curl --version &> /dev/null
if [[ "$?" -ne 0 ]]; then
  echo "cURL is required. Please install it."
  exit 1
fi

# grep is required
########################################
grep --version &> /dev/null
if [[ "$?" -ne 0 ]]; then
  echo "grep is required. Please install it."
  exit 1
fi

########################################
# Uncomment for debugging
########################################
# set -xv

########################################
# Set variables
########################################
# Given URL to test. Remove any trailing slashes.
URLTOTEST=$(echo $1 | sed 's:/*$::')
# Assume the site is not on WordPress, until proven otherwise
ISITWORDPRESS=0
# Log reasons that indicate a site is on WordPress
WHATIFOUND=""

########################################
# Validate the given URL by checking for 200 status code
########################################
URLSTATUSCODE=$(curl -L --write-out %{http_code} --silent --output /dev/null $URLTOTEST)
if [[ $URLSTATUSCODE != "200" ]]; then
  echo -e "[\033[31m$URLTOTEST\e[0m] is unreachable and cannot be tested."
  exit 1
fi

########################################
# Begin tests
########################################

# 01. Check if /wp-admin redirects to a successful page.
########################################

HTTPSTATUSCODE=$(curl -L --write-out %{http_code} --silent --output /dev/null $URLTOTEST/wp-admin)
if [[ $HTTPSTATUSCODE = "200" ]]; then
  ISITWORDPRESS=1
  WHATIFOUND="$WHATIFOUND I found /wp-login.php."
fi

# 02. Check for presence of /wp-content directory at the same URL we're testing
####################
curl -L --silent $URLTOTEST | grep -q "$URLTOTEST\/wp-content"
if [[ "$?" -ne 1 ]]; then
  ISITWORDPRESS=1
  WHATIFOUND="$WHATIFOUND I found the /wp-content directory."
fi

########################################
# Well? Is it WordPress?
########################################

if [[ $ISITWORDPRESS == 0 ]]; then
  echo -e "[\033[31m$URLTOTEST\e[0m] is probably not on WordPress."
elif [[ $ISITWORDPRESS == 1 ]]; then
  echo -e "[\033[32m$URLTOTEST\e[0m] is likely on WordPress.$WHATIFOUND"
else
  # Fallback scenario, which should never happen
  echo -e "[\033[32mError\e[0m] - $ISITWORDPRESS - This should not have happened."
  exit 1
fi
