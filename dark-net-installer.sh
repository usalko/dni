#!/bin/bash

# INSTALLATION SCRIPT FOR THE T&#10084;or-browser

LOCALE=ru
# LOCALE=en-US
VERSION=11.0.6
INSTALLATION_FOLDER=~/.847982`date +%s000`

CURRENT_FOLDER=$PWD

rm -fr ~/.847982*

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
# # https://tewarid.github.io/2011/05/10/access-imap-server-from-the-command-line-using-openssl.html
#
#
#

function get_arch {
    if uname -a | grep -q x86_64
    then
        echo "linux64";
    else
        echo "linux32";
    fi
}

TMP_ARCHIVE=/tmp/out`date +%s000`.tar.xz

function exit_message {
    echo $1
    rm -fr $TMP_ARCHIVE
    exit 1
}

function chr {
    [ "$1" -lt 256 ] || return 1
    printf "\\$(printf '%03o' "$1")"
}

KEYWORD=`chr 116``chr 111``chr 114`
echo $KEYWORD
DIRECT_REFERENCE=https://www.${KEYWORD}project.org/dist/${KEYWORD}browser/${VERSION}/${KEYWORD}-browser-`get_arch`-${VERSION}_${LOCALE}.tar.xz
if command -v curl &>/dev/null; then
    echo 'You have the curl'
    curl $DIRECT_REFERENCE -L -o $TMP_ARCHIVE || exit_message '001: The curl throw the issue when download the file $DIRECT_REFERENCE'
    elif command -v wget &>/dev/null; then
    echo 'You have the wget'
    wget $DIRECT_REFERENCE -O $TMP_ARCHIVE || exit_message '002: The wget throw the issue when download the file $DIRECT_REFERENCE'
else
    exit_message '003: Please install curl or wget'
fi

mkdir -p ${INSTALLATION_FOLDER}
tar -xf $TMP_ARCHIVE -C ${INSTALLATION_FOLDER}
mv ${INSTALLATION_FOLDER}/${KEYWORD}-browser_${LOCALE}/* $INSTALLATION_FOLDER
rm -fr ${INSTALLATION_FOLDER}/${KEYWORD}-browser_${LOCALE}

find ${INSTALLATION_FOLDER} -name *.desktop | xargs rm -fr

STARTER_NAME=run-`date +%s000`
mv ${INSTALLATION_FOLDER}/Browser/start-${KEYWORD}-browser ${INSTALLATION_FOLDER}/Browser/${STARTER_NAME}

DESKTOP_INSTALLER_FILE=${INSTALLATION_FOLDER}/${STARTER_NAME}.desktop

cat <<EOT >> ${DESKTOP_INSTALLER_FILE}
#!/usr/bin/env ./Browser/execdesktop


[Desktop Entry]
Type=Application
Name=Run Browser Setup
GenericName=Web Browser
Comment=
Categories=Network;WebBrowser;Security;
Exec=sh -c '"$(dirname "$*")"/Browser/startbrowser --detach || ([ ! -x "$(dirname "$*")"/Browser/startbrowser ] && "$(dirname "$*")"/startbrowser --detach)' dummy %k
X-RunBrowser-ExecShell=./Browser/startbrowser --detach
Icon=web-browser
StartupWMClass=Run Browser
EOT

SEARCH_STRING=start-${KEYWORD}-browser
sed -i "s/${SEARCH_STRING}/${STARTER_NAME}/g" ${INSTALLATION_FOLDER}/Browser/${STARTER_NAME}

SEARCH_STRING=`chr 84``chr 111``chr 114`
sed -i "s/${SEARCH_STRING}/Run/g" ${INSTALLATION_FOLDER}/Browser/execdesktop

sed -i "s/startbrowser/${STARTER_NAME}/g" ${DESKTOP_INSTALLER_FILE}
chmod +x ${DESKTOP_INSTALLER_FILE}

cp ${DESKTOP_INSTALLER_FILE} ${INSTALLATION_FOLDER}/Browser

cd ${INSTALLATION_FOLDER}
./${STARTER_NAME}.desktop --register-app

cd ${CURRENT_FOLDER}

exit_message '999: Success'
