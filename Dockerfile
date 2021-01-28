# Download base image
FROM ubuntu:20.04

# LABEL about the custom image
LABEL maintainer="WoW-CMS <pjctcms@gmail.com>"
LABEL version="0.1"
LABEL description="Docker image for BlizzCMS with Ubuntu 20.04"

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt update
RUN apt upgrade -y

# Install git, nginx, php extensions, mysql and supervisor from ubuntu repository
RUN apt install -y git nginx php7.4 php7.4-cli php7.4-curl php7.4-fpm php7.4-gd php7.4-gmp php7.4-mbstring php7.4-mysql php7.4-pdo php7.4-soap php7.4-xml php7.4-zip mysql-server supervisor && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

# Define the ENV variable
ENV nginx_vhost /etc/nginx/sites-available/default
ENV php_conf /etc/php/7.4/fpm/php.ini
ENV nginx_conf /etc/nginx/nginx.conf
ENV supervisor_conf /etc/supervisor/supervisord.conf

# Enable PHP-FPM on nginx virtualhost configuration
COPY default ${nginx_vhost}
RUN sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${php_conf} && \
    echo "\ndaemon off;" >> ${nginx_conf}

# Copy supervisor configuration
COPY supervisord.conf ${supervisor_conf}

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /var/www/html && \
    chown -R www-data:www-data /run/php

RUN rm -r -f /var/www/html && \
    cd /var/www/ && \
    git clone https://gitlab.com/WoW-CMS/BlizzCMS-Plus.git html

# Volume configuration
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Copy start.sh script and define default command for the container
COPY start.sh /start.sh
CMD ["./start.sh"]

# Expose Port for the Application 
EXPOSE 80 443 3306
