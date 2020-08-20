#!/bin/bash
cd "$(dirname "$0")"
cat ./signature

# echo -n Password:
# read -s PASSWORD
# echo

PASSWORD=$USER

docker rm -f sftp

docker run -d \
    -p 2222:22 \
    -v /Users/krashid/sftp:/home/$USER/upload \
    --name sftp \
    atmoz/sftp \
    $USER:$PASSWORD:$UID

echo -e "Using user: $USER"
echo -e "Using password: $PASSWORD"
