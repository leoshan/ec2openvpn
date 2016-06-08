#!/bin/bash
#Initial Openvpn Config
(echo yes;sleep 1;echo yes;sleep 1;echo 2;sleep 1;echo 943;sleep 1;echo 443;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo ;)| sudo ovpn-init --ec2

#Reset Openvpn Config
#(echo DELETE;sleep 3;echo yes;sleep 1;echo yes;sleep 1;echo 2;sleep 1;echo 943;sleep 1;echo 443;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo ;)| sudo ovpn-init --ec2

#admin_user=openvpn
#admin_pw=qwerty
#reroute_gw=1
#reroute_dns=1

#set openvpn password
(echo "password"; sleep 1; echo "password")|sudo passwd openvpn

#set openvpn password with openssl jiami
#PASSWORD=`openssl rand 8 -base64`
#echo -e "Password is $PASSWORD" > mima.txt
# (echo $PASSWORD; sleep 1; echo $PASSWORD)|sudo passwd openvpn


#Install mail command and send message to maill box
(echo ;sleep 3;echo ;) | sudo apt-get install mailutils -y
INSTANCE=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
echo -e "VPN usernam: openvpn,VPN password: ${admin_pw},VPN address:${INSTANCE}" | sudo mail -s "Openvpn Info" antiact@foxmail.com

sudo apt-get update -y && sudo apt-get upgrade -y
