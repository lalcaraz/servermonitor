#!/bin/bash

mydomain=my.domain.com

cowsay "Checking information for domain ${mydomain}"

myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
printf "\n\n::My Public IP address is: ${myip} \n"

printf "\n\n::Checking Domain-To-IP relationship ... \n"
host $mydomain

printf "\n\n::Checking Web Connections ... \n"
systemctl -q is-active nginx && printf "NGINX It is active.\n"
sudo su -c 'lsof -i TCP:80'
sudo su -c 'lsof -i TCP:443'

printf "\n\n::Checking SSL Certs ... \n"
sudo su -c './ssl-cert-check/ssl-cert-check -c /etc/letsencrypt/live/my.domain.com/fullchain.pem'

printf "\n\n::Checking 'Forever' Scripts running ... \n"
forever list | grep 'log'

printf "\n\n::Checking Disk and Memory ... \n"
df -kh .
printf "\n"
free -h
