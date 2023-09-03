#!/bin/bash

echo "Generate nginx.conf from $1"
# Check the command line argument value exists or not
if [ $1 != "" ]; then
  # Search all string based on date
  awk -v NGINX_HOME="$NGINX_HOME" '{sub(/\$NGINX_HOME/, NGINX_HOME)}1' $1 > nginx.conf
  awk -v API_HTTP_PORT="$API_HTTP_PORT" '{sub(/\$API_HTTP_PORT/, API_HTTP_PORT)}1' nginx.conf > temp.conf && mv temp.conf nginx.conf
  awk -v AUTH_HTTP_PORT="$AUTH_HTTP_PORT" '{sub(/\$AUTH_HTTP_PORT/, AUTH_HTTP_PORT)}1' nginx.conf > temp.conf && mv temp.conf nginx.conf
  awk -v WEB_HTTP_PORT="$WEB_HTTP_PORT" '{sub(/\$WEB_HTTP_PORT/, WEB_HTTP_PORT)}1' nginx.conf > temp.conf && mv temp.conf nginx.conf
  awk -v SSL_CERTS_CONF="$SSL_CERTS_CONF" '{sub(/\$SSL_CERTS_CONF/, SSL_CERTS_CONF)}1' nginx.conf > temp.conf && mv temp.conf nginx.conf
fi
