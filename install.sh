#!/usr/bin/env bash

dpkg –configure -a
apt update
apt install curl -y
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
chmod +x *.sh 