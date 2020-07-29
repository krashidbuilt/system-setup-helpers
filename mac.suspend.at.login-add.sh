#!/bin/bash
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
