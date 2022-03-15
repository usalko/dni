#!/bin/bash

function read_input {
    echo $@
    read INPUT_CONTENT
    RETURN_VALUE=$INPUT_CONTENT
}

function read_password {
    read -sp "$@" INPUT_CONTENT
    RETURN_VALUE=$INPUT_CONTENT
}

read_input Имя почтового сервера, при нажатии Enter без ввода имени будет подставлено значение gmail.com:
SERVER_NAME=$RETURN_VALUE
read_input Имя пользователя почтового сервера ваш email:
USER_NAME=$RETURN_VALUE
read_input Введите пароль:
SMTP_PASSWORD=$RETURN_VALUE

echo $SERVER_NAME
echo $USER_NAME
echo $SMTP_PASSWORD

#PORTS
# Port 25, 587, 465, or 2525)

subject="Subject of my email"
txtmessage="linux ru"
username=$USER_NAME
password=$SMTP_PASSWORD
From="$USER_NAME"
rcpt='gettor@torproject.org'
from_name='N BOINA'
rcpt_name='Nicolas Hulot'

SMTP_SERVER=smtp-relay.gmail.com

{
sleep 0.3;
echo "EHLO $(echo $USER_NAME | cut -d "@" -f 2 )"
sleep 0.3;

# Comment this line if you use smtp without authentication
echo "AUTH PLAIN $(echo -ne "\0$username\0$password" | base64)"
sleep 0.3;

## uncomment if using smtp without encryption with telnet
#echo "AUTH LOGIN"
#sleep 0.3;
#echo $(echo -ne $username | base64) && echo $username64 
#sleep 0.3;
#echo $(echo -ne "\0$username\0$password" | base64)

sleep 0.3;
echo "MAIL FROM:<$From>"

sleep 0.3;
echo "rcpt to:<$rcpt>"

sleep 0.3;
echo "DATA"

sleep 0.3
echo "Subject: $subject"

sleep 0.3
echo "MIME-Version: 1.0"

sleep 0.3
echo "From: $from_name <$From>"

sleep 0.3
echo "Content-Type: text/html; charset=”UTF-8″"

sleep 0.3
echo "To: $rcpt_name <$rcpt>"

sleep 0.3
echo "Content-Transfer-Encoding: quoted-printable"

sleep 0.3
echo $txtmessage

sleep 0.3;
echo "."

sleep 0.3;

## uncomment one of the following line depending on the encryption mode you want to use.

#} | telnet smtp-relay.gmail.com 25
#} | openssl s_client -starttls smtp -crlf -connect smtp-relay.gmail.com:587
} | openssl s_client -crlf -connect $SMTP_SERVER:465

echo Посмотрите пожалуйста почту, скопируйте ссылку и удалите сообщение
