#!/bin/bash
cd "$(dirname "$0")"
cat ./signature

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

# if you change these variables, you need to update the daemon, config, plist, etc (don't fucking change them 😜)
NGROK_BINARY=/usr/local/bin/ngrok
NGROK_CONF_DIR=/usr/local/etc/ngrok

if [[ ! -f "$NGROK_BINARY" ]]; then
    echo "$NGROK_BINARY binary doesn't exist."
else
    echo "$NGROK_BINARY binary exists."
    echo "You can remove it manually if you want by running: \"sudo rm -rf $NGROK_BINARY\""
fi

if [[ ! -d "$NGROK_CONF_DIR" ]]; then
    echo "$NGROK_CONF_DIR directory doesn't exist."
else
    echo "$NGROK_CONF_DIR directory exists."
    echo "You can remove it manually if you want by running: \"sudo rm -rf $NGROK_CONF_DIR\""
fi

echo "Removing config file: ${NGROK_CONF_DIR}/ngrok.yml"
rm -rf ${NGROK_CONF_DIR}/ngrok.yml

echo "Removing ngrokd file: /usr/local/bin/ngrokd"
rm -rf /usr/local/bin/ngrokd

echo "Removing com.ngrok.onstartup.plist file: /Library/LaunchDaemons/com.ngrok.onstartup.plist"
rm -rf /Library/LaunchDaemons/com.ngrok.onstartup.plist
