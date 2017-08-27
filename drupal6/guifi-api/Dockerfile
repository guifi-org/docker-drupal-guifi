# Set the base image
FROM debian:stretch

LABEL net.guifi.vendor="guifi-dev"
LABEL version="1.0"
LABEL description="API REST with symfony"
#would work?
#LABEL maintainer="https://riot.im/app/#/room/#guifi-dev-public:matrix.org"


RUN apt-get update && apt-get dist-upgrade -y \
  && apt-get install -y apache2 php7.0 php7.0-mysqlnd php7.0-gd \
  php7.0-xdebug libapache2-mod-php7.0 php7.0-intl wget \
  gzip git unzip mysql-client \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*
# TODO add vim (tomorrow)

# Copy over the apache configuration file
COPY ./drupal.conf /etc/apache2/sites-available/drupal.conf

# Enable new site
RUN a2enmod rewrite
RUN a2dissite 000-default.conf
RUN a2ensite drupal.conf

# Define Volume for Drupal
VOLUME /usr/share/drupal/guifi-web

# Preparing development dir
RUN mkdir /usr/share/guifi-dev/

# Copying Entrypoint scripts
COPY ./docker-entrypoint.sh /
COPY ./drupal-entry.pl /

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
