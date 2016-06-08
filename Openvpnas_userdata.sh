#!/bin/bash
admin_user=openvpn
admin_pw=qwerty
reroute_gw=1
reroute_dns=1
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install mailutils -y

(echo "password"; sleep 1; echo "password")|sudo passwd openvpn

#PASSWORD=`openssl rand 8 -base64`
#echo -e "Password is $PASSWORD" > mima.txt
# (echo $PASSWORD; sleep 1; echo $PASSWORD)|sudo passwd openvpn
sudo ovpn-init --ec2 <<EOF
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
