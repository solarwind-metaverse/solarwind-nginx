#!/bin/bash
./prepare.sh nginx-template.conf
nginx_process="$(ps aux | grep nginx | grep root | awk '{ print $1 }')"
if [ ! -z "${nginx_process}" ]
then
  echo "Stopping nginx"
  sudo nginx -s stop
fi
echo "Starting nginx"
sudo nginx -g 'daemon off;' -c $NGINX_HOME/nginx.conf
