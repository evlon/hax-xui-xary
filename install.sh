#!/usr/bin/env bash

#更新软件源
apt update
#启用 BBR TCP 拥塞控制算法
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p

#安装xray：
# installed: /etc/systemd/system/xray.service
# installed: /etc/systemd/system/xray@.service

# installed: /usr/local/bin/xray
# installed: /usr/local/etc/xray/*.json

# installed: /usr/local/share/xray/geoip.dat
# installed: /usr/local/share/xray/geosite.dat

# installed: /var/log/xray/access.log
# installed: /var/log/xray/error.log
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install
systemctl enable xray

#安装 Caddy
apt install -y debian-keyring debian-archive-keyring apt-transport-https -y
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
apt update -y
apt install caddy -y

#添加配置
cp -f ./etc/Caddyfile /etc/caddy/Caddyfile
cp -f ./etc/xary-config.json /usr/local/etc/xray/config.json