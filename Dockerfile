# Pull base image.
FROM dockerfile/ubuntu

# Install Nginx.
RUN \
  add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Get the repository from Github
RUN git clone https://83cbb505d46274d68f5cee34b032c89edfbc5d13:x-oauth-basic@github.com/sosocial/sosocial-nginx.git /home/sosocial-nginx

# Define working directory.
WORKDIR  /home/sosocial-nginx

ADD sosocial.conf /etc/sites-enabled/sosocial.conf

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define new working directory.
WORKDIR /etc/nginx

# Expose ports.
EXPOSE 80
EXPOSE 443

# Define default command.
CMD ["nginx"]