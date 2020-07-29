#!/bin/bash
cd "$(dirname "$0")"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

echo ""
echo ""
echo "Creating: com.docker.machine.default.plist"
\cp ./config/com.docker.machine.default.plist /Library/LaunchDaemons/com.docker.machine.default.plist
cat /Library/LaunchDaemons/com.docker.machine.default.plist
