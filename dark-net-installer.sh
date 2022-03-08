#!/bin/bash

# INSTALLATION SCRIPT FOR THE Tor-browser

# TODO:
# Check wget and try the reference in attempt to download tor
# Check curl and try the reference in attempt to download tor
# Set manual variable to true and display suggestion to send email
# Wait for link
# ====== download success
# Wait answer for the question, could you check gpg?
# = The answer yes
# Download the asc
# Check gpg installation
# If manual then do one sequence of commands
# If not manual do another sequence of checks
# ====== check success
# Request folder to installation
# Unpack to installation folder
# Request the page https://check.torproject.org/
# 

function get_arch {
    if uname -a | grep -q x86_64
    then
        echo "linux64";
    else
        echo "linux32";
    fi
}

LOCALE=ru
# LOCALE=en-US
VERSION=11.0.6
DIRECT_REFERENCE=https://www.torproject.org/dist/torbrowser/${VERSION}/tor-browser-`get_arch`-${VERSION}_${LOCALE}.tar.xz
# if [ test curl ]; then
#     echo 'You have the curl'
#     curl 
# elif [ test wget ]; then
#     echo 'You have the wget'
# fi
echo $DIRECT_REFERENCE