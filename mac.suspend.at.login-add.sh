#!/bin/bash
# Good use to "suspend" the user if autologin is enabled
# currently being used because docker won't load with the system daemon and requires user to login to kick off
# haven't tried, but autologin can be enabled with: https://github.com/xfreebird/kcpassword

cd "$(dirname "$0")"

if [ "$EUID" -eq 0 ]; then
    echo "Please don't run as root"
    exit
fi

LOCAL_AGENT_DIR=~/Library/LaunchAgents

if [[ ! -d "$LOCAL_AGENT_DIR" ]]; then
    echo "$LOCAL_AGENT_DIR directory doesn't exist."
    echo "Creating directory ${LOCAL_AGENT_DIR}"
    mkdir -p ${LOCAL_AGENT_DIR}
else
    echo "$LOCAL_AGENT_DIR directory exists."
fi

echo ""
echo ""
echo "Adding: com.krashidbuilt.user.suspend.onstartup.plist"
\cp ./config/com.krashidbuilt.user.suspend.onstartup.plist ${LOCAL_AGENT_DIR}/com.krashidbuilt.user.suspend.onstartup.plist
cat ${LOCAL_AGENT_DIR}/com.krashidbuilt.user.suspend.onstartup.plist
