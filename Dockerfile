# Base image
FROM ubuntu:latest

# Set working directory
WORKDIR /nginx

# Install Nginx and sudo
RUN apt-get update && \
    apt-get install -y nginx sudo

# Allow running Nginx with sudo
RUN echo 'user ALL=(root) NOPASSWD: /usr/sbin/nginx' > /etc/sudoers.d/nginx && \
    chmod 0440 /etc/sudoers.d/nginx

COPY . .

RUN chown -R www-data:www-data /nginx/static

RUN sudo chmod 755 /nginx/static && \
    sudo chmod 755 /nginx/static/.well-known && \
    sudo chmod 755 /nginx/static/.well-known/pki-validation && \
    sudo chmod 644 /nginx/static/.well-known/pki-validation

EXPOSE 80
EXPOSE 443

CMD ["./start.sh"]