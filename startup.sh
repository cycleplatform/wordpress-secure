# Undo SSL config if not enabled:
if [ "$CYCLE_FEATURES_TLS_ENABLED" == "0" ]
then
    echo "Environment Variable 'CYCLE_FEATURES_TLS_ENABLED' set to 0, disabling SSL config"
    unlink /etc/apache2/sites-enabled/default-ssl.conf
    unlink /etc/apache2/mods-enabled/ssl.load
    unlink /etc/apache2/mods-enabled/ssl.conf
    unlink /etc/apache2/mods-enabled/socache_shmcb.load
    
    if cmp -s /var/www/html/.htaccess /usr/local/.htaccess; then
        rm /var/www/html/.htaccess
    fi
else
    echo "Using SSL configuration"
    if [ ! -f /var/www/html/.htaccess]; then
        cp /usr/local/.htaccess /var/www/html/.htaccess
    fi
fi

/usr/local/bin/docker-entrypoint.sh apache2-foreground
