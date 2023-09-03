# Base image
FROM ubuntu:latest

# Set working directory
WORKDIR /app

# Install Nginx and sudo
RUN apt-get update && apt upgrade && apt-get install sudo

# Install Node.js and npm
RUN sudo apt-get install -y ca-certificates curl gnupg
RUN sudo mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN export NODE_MAJOR=20 && \
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
RUN sudo apt-get update
RUN sudo apt-get install -y nodejs
RUN sudo apt-get install -y git

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