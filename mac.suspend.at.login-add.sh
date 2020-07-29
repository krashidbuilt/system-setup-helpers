#!/bin/bash
cd "$(dirname "$0")"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

echo ""
echo ""
echo "Creating: com.krashidbuilt.user.suspend.onstartup.plist"
\cp ./config/com.krashidbuilt.user.suspend.onstartup.plist /Library/LaunchAgents/com.krashidbuilt.user.suspend.onstartup.plist
cat /Library/LaunchAgents/com.krashidbuilt.user.suspend.onstartup.plist
