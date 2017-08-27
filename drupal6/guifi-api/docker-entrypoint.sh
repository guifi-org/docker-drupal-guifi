#!/usr/bin/env bash
#cd /usr/share/drupal/guifi-web
#drush si -y --site-name=guifi.net --db-url=mysqli://guifi:guifi@database/guifidev --account-name=admin --account-pass=drupal
# Configuration script in Perl
#perl /drupal-entry.pl

# inspired by src https://github.com/docker-library/mysql/blob/master/5.6/docker-entrypoint.sh
if [ ! -d "/init" ]; then

    # PHP timezone
    PHPTIMEZONE=$(cat <<EOF
date.timezone = "Europe/Madrid"
EOF
)
    echo "${PHPTIMEZONE}" > /etc/php/7.0/cli/conf.d/timezone.ini
    echo "${PHPTIMEZONE}" > /etc/php/7.0/apache2/conf.d/timezone.ini
    
    # guifi-api configuration
    git clone https://github.com/guifi-org/guifi-api /var/www/html/guifi-api
    cd /var/www/html/guifi-api/
    PARAMETERS=$(cat <<EOF
parameters:
    database_host: 127.0.0.1
    database_port: null
    database_name: ${GUIFI_DB}
    database_user: ${GUIFI_USER_DB}
    database_password: ${GUIFI_USER_DB_PWD}
    mailer_transport: smtp
    mailer_host: 127.0.0.1
    mailer_user: null
    mailer_password: null
    secret: ${API_SECRET}
EOF
)
    echo "${PARAMETERS}" > app/config/parameters.yml
    
    # Install guifi-api dependencies
    php composer.phar install


    touch /init
    echo "Guifi.net API (symfony) successfully installed in Docker image!" 

fi

/usr/sbin/apache2ctl -D FOREGROUND
