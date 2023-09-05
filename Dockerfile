# Base image
FROM ubuntu:latest

# Set working directory
WORKDIR /app

# Update apt and install sudo
RUN apt-get update && apt upgrade && apt-get install sudo

# Install Git and NGINX
RUN sudo apt-get install -y git nginx

# Copy app source code
RUN git clone https://github.com/solarwind-metaverse/solarwind-nginx.git

WORKDIR /app/solarwind-nginx

# Allow running Nginx with sudo
RUN echo 'user ALL=(root) NOPASSWD: /usr/sbin/nginx' > /etc/sudoers.d/nginx && \
    chmod 0440 /etc/sudoers.d/nginx

COPY ssl/zero-ssl /app/solarwind-nginx/ssl/zero-ssl

EXPOSE 80
EXPOSE 443

CMD ["./start.sh"]