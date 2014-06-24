ec2openvpn
==========

Openvpn access server on ec2

To do as "https://docs.openvpn.net/how-to-tutorialsguides/virtual-platforms/amazon-ec2-appliance-ami-quick-start-guide/"

概述：使用基于openvpn公司提供的openvpn的商业版本openvpn access sever镜像，新建一个micro的instance。
简单配置之后就可以建立了2个账号使用的openvpn服务器。购买license，可以提供更多账号使用。

1. 按照向导新建一个免费的micro instance，镜像使用 OpenVPN Access Server 2.0.8，可在社区AMI搜索，eg. ami-e3753ce。
2. 设置过程中的参数按照普通虚拟机建设即可，最后虚拟机启动后再配置参数（也可以在高级设置添加user-data，不推荐）。
3. 安全组设置：TCP端口443、943；UDP端口1194.
4. 选择分配静态IP、Public IP或者设置域名进行连接（当前使用public ip）
5. 使用openvpnas账号和private key-pair，用putty登录虚拟机。登录成功后参照OpenVPNAS-Setup-Wizard设置向导进行配置。
    如果需要再次运行此向导，使用sudo ovpn-init --ec2 命令。
6. 首先使用sudo passwd openvpn设置密码，然后使用openvpn账号和Public IP在浏览器上登录Openvpn Web Admin UI。


