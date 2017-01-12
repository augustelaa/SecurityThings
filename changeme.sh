#!/bin/bash

#
## Author Augusto Henrique da Conceição
## This script changes your virtual identity (IP Address and MAC Address)
#

clear
echo ""
echo "[--ChangeME--]"
echo "This script changes your virtual identity (IP Address and MAC Address)"
echo "Usage: ./changeme.sh interface ip mac"

if [[ $1 = '' && $2 = '' && $3 = '' ]]; then
	exit 1
fi

echo ""
echo ""

if [[ $2 = '' ]]; then
   exit 1
fi

if [[ $3 != '' ]]; then
   echo "Changing MAC..."
	macchanger -m $3 $1
	echo ""
fi

echo "Changing IP..."
ifconfig $1 $2 netmask 255.255.255.0
echo ""

echo "Adding gateway rule at 192.168.6.1..."
route add default gw 192.168.6.1 $1
echo ""

echo "Testing acess at google.com..."
curl -v --interface $1 http://google.com/
echo ""

route -n