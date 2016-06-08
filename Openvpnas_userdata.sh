#!/bin/bash
admin_user=openvpn
admin_pw=qwerty
reroute_gw=1
reroute_dns=1
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install mailutils -y
#sudo passwd openvpn
#qwerty
#qwerty
#PASSWORD=`openssl rand 8 -base64`
INSTANCE=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
echo -e "VPN usernam: openvpn,VPN password: ${admin_pw},VPN address:${INSTANCE}" | sudo mail -s "Openvpn Info" antiact@foxmail.com
