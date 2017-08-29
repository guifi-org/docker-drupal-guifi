#!/usr/bin/env bash

if [ ! -d "/init" ]; then

    # interactions with database, here

    touch /init
    echo "Guifi.net API (symfony) successfully installed in Docker image!" 

fi

if [ NULL${DEV_SERVER} == "NULLyes" ]; then

    php /var/www/html/guifi-api/bin/console server:run 0.0.0.0:90

else

    /usr/sbin/apache2ctl -D FOREGROUND

fi
