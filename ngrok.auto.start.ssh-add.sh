#!/bin/bash
cd "$(dirname "$0")"
cat ./signature

if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

AUTH_TOKEN=${1}
REMOTE_ADDRESS=${2}

if [[ -z "${AUTH_TOKEN}" ]]; then
    echo "AUTH_TOKEN not defined ... please specify as first parameter"
    exit 1
fi

if [[ -z "${REMOTE_ADDRESS}" ]]; then
    echo "REMOTE_ADDRESS not defined ... please specify as second parameter, example: 1.tcp.ngrok.io:29480"
    exit 1
fi

# if you change these variables, you need to update the daemon, config, plist, etc (don't fucking change them 😜)
NGROK_BINARY=/usr/local/bin/ngrok
NGROK_CONF_DIR=/usr/local/etc/ngrok

if [[ ! -f "$NGROK_BINARY" ]]; then
    echo "$NGROK_BINARY binary doesn't exist."

    # wget is used to grab the zip file
    if [[ ! -f "/usr/local/bin/wget" ]]; then
        echo "Installing wget with brew"
        brew install wget
    fi

    echo "Installing ngrok to ${NGROK_BINARY}"
    wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-darwin-amd64.zip
    unzip ./ngrok-stable-darwin-amd64.zip
    rm -rf ./ngrok-stable-darwin-amd64.zip
    mv ./ngrok /usr/local/bin/ngrok
else
    echo "$NGROK_BINARY binary exists."
fi

if [[ ! -d "$NGROK_CONF_DIR" ]]; then
    echo "$NGROK_CONF_DIR directory doesn't exist."
    echo "Creating config directory ${NGROK_CONF_DIR}"
    mkdir -p ${NGROK_CONF_DIR}
else
    echo "$NGROK_CONF_DIR directory exists."
fi

echo ""
echo ""
echo "authtoken: ${AUTH_TOKEN}" >${NGROK_CONF_DIR}/ngrok.yml
echo "remote_management: null" >>${NGROK_CONF_DIR}/ngrok.yml
echo "log: /var/log/ngrok.log" >>${NGROK_CONF_DIR}/ngrok.yml
echo "tunnels:" >>${NGROK_CONF_DIR}/ngrok.yml
echo "  ssh:" >>${NGROK_CONF_DIR}/ngrok.yml
echo "      addr: 22" >>${NGROK_CONF_DIR}/ngrok.yml
echo "      proto: tcp" >>${NGROK_CONF_DIR}/ngrok.yml
echo "      remote_addr: ${REMOTE_ADDRESS}" >>${NGROK_CONF_DIR}/ngrok.yml
cat ${NGROK_CONF_DIR}/ngrok.yml

echo ""
echo ""
echo "Installing ngrokd"
\cp ./config/ngrokd /usr/local/bin/ngrokd
chmod +x /usr/local/bin/ngrokd
cat /usr/local/bin/ngrokd

echo ""
echo ""
echo "Creating plist for ngrokd"
\cp ./config/com.ngrok.onstartup.plist /Library/LaunchDaemons/com.ngrok.onstartup.plist
cat /Library/LaunchDaemons/com.ngrok.onstartup.plist
