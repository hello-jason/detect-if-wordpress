#!/bin/bash
# Declare array of URLs to be tested
SITESARRAY=(
  # WordPress on WP Engine
  wpengine.com
  # Not a WordPress site
  google.com
  # Bedrock WordPress
  roots.io
  # Bedrock WordPress
  immense.net
  # Not WordPress
  ebay.com
  # WordPress
  lsu.edu
  # WordPress
  wordpress.com
  # WordPress
  gatorworks.net
  # Not WordPress
  amazon.com
  # Bedrock WordPress, Multisite
  www.lslbc.louisiana.gov
  # Old Magento
  dp-tuner.com
  # Newer Magento
  shopsweetsandtreats.com
  # WordPress
  blog.shopsweetsandtreats.com
  # Custom system
  hybrid-racing.com
  # Magento (but also WordPress?)
  technogym.com/us
  # Crazy redirects
  isitchristmasyet.com
  # Not WordPress
  stackoverflow.com
)

# Iterate over each URL in the array
for url in ${SITESARRAY[*]}; do
  # Pass each URL from the array into the WordPress detection script
  bash wpdetect.sh --url "$url"
  # Some spacing, please
  echo
done

exit
