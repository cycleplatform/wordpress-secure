FROM wordpress:latest 

COPY default-ssl.conf /etc/apache2/sites-available 
VOLUME /var/www/html

# Copy it so we can link/unlink depending on SSL settings
COPY .htaccess /usr/local

RUN echo "memory_limit = 150M\n" \
         "upload_max_filesize = 150M\n" \
         "post_max_size = 150M\n" \
         > /usr/local/etc/php/conf.d/uploads.ini
         

EXPOSE 443

COPY startup.sh /usr/local
RUN chmod +x /usr/local/startup.sh
ENTRYPOINT ["/bin/bash", "-c", "/usr/local/startup.sh"]
