## VM通过先stop再start后，自动化更换服务IP能力
    问题：最近FW的政策是检测到FQ行为后，将特定IP加入到某个池子中，然后在建立握手的时候，故意丢TLS特征包，导致TLS加密失败服务器验证不成功，连接失败。
    解决办法：方式就是AWS 手机client，Stop主机再Start主机，自动更换一个随机IP，然后用新IP登录Openvpn的WebUI重新更新主机Host FQDN，然后重新连接Openvpn服务器下载新的Client。
    实施方案：
    1）虽然可以通过固定域名来解决，更改DNS映射关系，但是还是要多做一步，需要登录阿里云去维护我的DNS记录。
    2）在EC2主机重启的时候，直接更改Openvpn的Host FQDN，然后直接用client去下载登录文件就好。节省一步，在开机自动脚本中加入几行命令。

## 调试过程分析
    0. 为了等待openvpn服务启动之后再更改IP地址，所以：sleep 30
    1. 获取AWS EC2实例的public IP地址
    HOST=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
    2. 使用openvpn命令设置IP地址，并更新服务
    sudo /usr/local/openvpn_as/scripts/sacli --key "host.name" --value $HOST ConfigPut
    sudo /usr/local/openvpn_as/scripts/sacli start

## 开机自启动脚本制作
    将上面三个命令制作开机启动脚本（https://zhuanlan.zhihu.com/p/98804785）
    1. sudo vi /lib/systemd/system/rc.local.service

    在末尾添加 [Install] 字段，如下：

    [Install]  
    WantedBy=multi-user.target  
    Alias=rc-local.service

    2. 创建 rc.local脚本


    sudo vi /etc/rc.local
    增加上面的脚本：


    #!/bin/bash
    sleep 30
    HOST=`curl http://169.254.169.254/latest/meta-data/public-ipv4`
    sudo /usr/local/openvpn_as/scripts/sacli --key "host.name" --value $HOST ConfigPut
    sudo /usr/local/openvpn_as/scripts/sacli start
    sudo echo "Update IP $HOST sucess" > /home/openvpnas/ChangeIP.log


    3. sudo chmod a+x /etc/rc.local

    4. sudo ln -s /lib/systemd/system/rc.local.service /etc/systemd/system/
