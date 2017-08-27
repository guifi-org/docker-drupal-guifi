# Set the base image
FROM debian:stretch

LABEL net.guifi.vendor="guifi-dev"
LABEL version="1.0"
LABEL description="API REST with symfony"
#would work?
#LABEL maintainer="https://riot.im/app/#/room/#guifi-dev-public:matrix.org"


RUN apt-get update && apt-get dist-upgrade -y \
  && apt-get install -y apache2 php php-mysqlnd php-gd \
  php7.0-xdebug libapache2-mod-php php-intl wget php-xml \
  gzip git unzip mysql-client vim \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

#CHECK
# separate php install code to guifi-api-bootstrap
#COPY ./guifi-api-bootstrap.sh /
#RUN /guifi-api-bootstrap.sh

# Copy over the apache configuration file
COPY ./drupal.conf /etc/apache2/sites-available/drupal.conf

# Enable new site
RUN a2enmod rewrite
RUN a2dissite 000-default.conf
RUN a2ensite drupal.conf

# TODO Define Volume for Drupal
#VOLUME /usr/share/drupal/guifi-web

# Preparing development dir
RUN mkdir /usr/share/guifi-dev/

# Copying Entrypoint scripts
COPY ./docker-entrypoint.sh /

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
