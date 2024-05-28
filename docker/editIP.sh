#!/bin/bash

# Usage: ./replace_ip.sh <new_ip_address>

# Check if the user provided an IP address
if [ -z "$1" ]; then
  echo "Usage: $0 <new_ip_address>"
  exit 1
fi

# Assign the new IP address from the first argument
NEW_IP=$1

# Define the file paths
FILE_PATH1="api/config/default.json"
FILE_PATH2="issuer-admin/config/admin/config.json"
FILE_PATH3="issuer-web/config/web/config.json"
FILE_PATH4="keycloak/config/realm-export.json"
FILE_PATH5="manage/config/manage/config.json"

# Check if the files exist
if [ ! -f "$FILE_PATH1" ]; then
  echo "File $FILE_PATH1 does not exist."
  exit 1
fi

if [ ! -f "$FILE_PATH2" ]; then
  echo "File $FILE_PATH2 does not exist."
  exit 1
fi

if [ ! -f "$FILE_PATH3" ]; then
  echo "File $FILE_PATH3 does not exist."
  exit 1
fi

if [ ! -f "$FILE_PATH4" ]; then
  echo "File $FILE_PATH4 does not exist."
  exit 1
fi

if [ ! -f "$FILE_PATH5" ]; then
  echo "File $FILE_PATH5 does not exist."
  exit 1
fi

# Replace the IP address on line 2 of the first file
sed -i '2s/"host": "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}",/"host": "'$NEW_IP'",/' "$FILE_PATH1"

# Replace all occurrences of the IP address in the second file
sed -i -E "s#http://[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:#http://$NEW_IP:#g" "$FILE_PATH2"

# Replace all occurrences of the IP address in the third file
sed -i -E "s#http://[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:#http://$NEW_IP:#g" "$FILE_PATH3"

# Replace all occurrences of the IP address in the fourth file
sed -i -E "s#http://[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:#http://$NEW_IP:#g" "$FILE_PATH4"

# Replace specific lines in the fifth file
sed -i -E "s#(export ADMIN_WEB_HOST_NAME=http://)[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+#\1$NEW_IP#g" "$FILE_PATH5"
sed -i -E "s#(export PUBLIC_WEB_HOST_NAME=http://)[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+#\1$NEW_IP#g" "$FILE_PATH5"
sed -i -E "s#http://[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:#http://$NEW_IP:#g" "$FILE_PATH5"

echo "IP address updated to $NEW_IP in $FILE_PATH1, $FILE_PATH2, $FILE_PATH3, $FILE_PATH4, and $FILE_PATH5"
