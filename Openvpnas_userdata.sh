#!/bin/bash
admin_user=openvpn
admin_pw=qwerty
reroute_gw=1
reroute_dns=1
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install mailutils -y
#sudo passwd openvpn
#qwerty
#qwerty
#PASSWORD=`openssl rand 8 -base64`
sudo ovpn-init --ec2
yes
yes
2
943
443
yes
yes
yes
yes
yes

INSTANCE=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
echo -e "VPN usernam: openvpn,VPN password: ${admin_pw},VPN address:${INSTANCE}" | sudo mail -s "Openvpn Info" antiact@foxmail.com
