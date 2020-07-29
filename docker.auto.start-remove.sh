#!/bin/bash
cd "$(dirname "$0")"

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

echo ""
echo ""
echo "Removing: com.docker.machine.default.plist"
rm -rf /Library/LaunchDaemons/com.docker.machine.default.plist
