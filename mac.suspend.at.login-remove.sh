#!/bin/bash
cd "$(dirname "$0")"

if [ "$EUID" -eq 0 ]; then
    echo "Please don't run as root"
    exit
fi

LOCAL_AGENT_DIR=~/Library/LaunchAgents

echo "Removing ${LOCAL_AGENT_DIR}/com.krashidbuilt.user.suspend.onstartup.plist"
rm -rf ${LOCAL_AGENT_DIR}/com.krashidbuilt.user.suspend.onstartup.plist
