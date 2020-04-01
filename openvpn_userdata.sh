#!/bin/bash
#Initial Openvpn Config
(echo yes;sleep 1;echo yes;sleep 1;echo 2;sleep 1;echo 943;sleep 1;echo 443;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo yes;sleep 1;echo ;)| sudo ovpn-init --ec2
#set openvpn password
(echo "password"; sleep 1; echo "password")|sudo passwd openvpn
#Install mail command and send message to mail box
(echo ;sleep 3;echo ;) | sudo apt-get install mailutils -y
INSTANCE=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
echo -e "VPN username: openvpn,VPN password: ${admin_pw},VPN address:${INSTANCE}" | sudo mail -s "Openvpn Info" antiact@foxmail.com
sudo apt-get update -y && sudo apt-get upgrade -y

#Openvpn 2.75 @ ubuntu 18.04 Auto change service IP address 
sudo echo "[Install]" >> /lib/systemd/system/rc.local.service
sudo echo "WantedBy=multi-user.target" >> /lib/systemd/system/rc.local.service
sudo echo "Alias=rc-local.service" >> /lib/systemd/system/rc.local.service
sudo echo "#!/bin/bash" >> /etc/rc.local
sudo echo "sleep 30" >> /etc/rc.local
sudo echo "HOST=`curl http://169.254.169.254/latest/meta-data/public-ipv4`" >> /etc/rc.local
sudo echo "sudo /usr/local/openvpn_as/scripts/sacli --key "host.name" --value $HOST ConfigPut" >> /etc/rc.local
sudo echo "sudo /usr/local/openvpn_as/scripts/sacli start" >> /etc/rc.local
sudo echo "sudo echo "Update IP $HOST sucess" >> ~/ChangeIP.log" >> /etc/rc.local
sudo chmod a+x /etc/rc.local
sudo ln -s /lib/systemd/system/rc.local.service /etc/systemd/system/
