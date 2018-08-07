FROM wordpress:latest 

COPY default-ssl.conf /etc/apache2/sites-available 
RUN ln -s /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf 

COPY .htaccess /var/www/html 

RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/ssl.load 

RUN ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/ssl.conf

RUN ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled/socache_shmcb.load

RUN echo "memory_limit = 150M\n" \
         "upload_max_filesize = 150M\n" \
         "post_max_size = 150M\n" \
         > /usr/local/etc/php/conf.d/uploads.ini
         
VOLUME /var/www/html

EXPOSE 443
