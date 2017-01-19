# Get image fromdebian
FROM debian

# Get packages needed to get this running
RUN apt-get update && apt-get install -y  \ 
   nginx \
   php5-fpm \
   php5-gd \
   unzip \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Run nginx to foreground
RUN sed -i '1s/^/daemon off; \n/' /etc/nginx/nginx.conf

# Download and extract KODExplorer
ADD https://github.com/kalcaddle/KODExplorer/archive/master.zip /var/www/html/
RUN unzip /var/www/html/master.zip -d /var/www/html/ \
    && mv /var/www/html/KODExplorer-master /var/www/html/kodexplorer \
	&& chown www-data:www-data -R /var/www/html/kodexplorer \
	&& rm /var/www/html/master.zip

# Update NGINX default site to point and load KODExplorer
RUN rm /etc/nginx/sites-available/default
COPY nginx-default-site /etc/nginx/sites-available/default

# Copy start up script
COPY start.sh /

EXPOSE 80
CMD ["/start.sh"]
