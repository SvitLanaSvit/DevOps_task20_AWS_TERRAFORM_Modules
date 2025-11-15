#!/bin/bash
PACKAGENAME="nginx"
apt update && apt install $PACKAGENAME -y
systemctl enable nginx && systemctl start nginx
 