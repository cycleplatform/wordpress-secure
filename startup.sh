# Undo SSL config if not enabled:
if [ "$SSL_ENABLED" = "0" ]
then
    echo "SSL_ENABLED env variable set to 0, disabling SSL config"
    unlink /etc/apache2/sites-enabled/default-ssl.conf
    unlink /etc/apache2/mods-enabled/ssl.load
    unlink /etc/apache2/mods-enabled/ssl.conf
    unlink /etc/apache2/mods-enabled/socache_shmcb.load
    unlink /var/www/html/.htaccess
else
    echo "Using SSL configuration"
    ln -s /usr/local/.htaccess /var/www/html/.htaccess
fi

/usr/local/bin/docker-entrypoint.sh apache2-foreground