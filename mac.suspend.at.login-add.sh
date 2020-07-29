#!/bin/bash
cd "$(dirname "$0")"

echo "This isn't currently supported: https://stackoverflow.com/questions/42637339/how-to-start-docker-for-mac-daemon-on-boot"
exit 1

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

echo ""
echo ""
echo "Creating: com.krashidbuilt.user.suspend.onstartup.plist"
\cp ./config/com.krashidbuilt.user.suspend.onstartup.plist /Library/LaunchAgents/com.krashidbuilt.user.suspend.onstartup.plist
cat /Library/LaunchAgents/com.krashidbuilt.user.suspend.onstartup.plist
