#!/bin/bash 


a=0
flagKeepAlive="started"
sleep 15
while [ $a -le 10 ]
do
    sleep 2

	nginxStatus="start";
file="/var/run/nginx.pid"
if [ -f "$file" ]
then
	nginxStatus="start";
else
	nginxStatus="";
fi

    value=`ip a show eno2 up |grep inet`
    value1=`ip a show eno3 up |grep inet`
    if [ "$value" = "" ] || [ "$value1" = "" ] || [ "$nginxStatus" = "" ]
    then
    if [ "$flagKeepAlive" = "started" ]
    then
    flagKeepAlive="stopped"
    stopKeepAlive=`service keepalived stop`
    fi
    else
    if [ "$flagKeepAlive" = "stopped" ]
    then
    flagKeepAlive="started"
    startKeepAlive=`service keepalived start`
    fi
    fi
done