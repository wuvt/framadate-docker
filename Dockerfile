FROM php:apache

RUN apt-get update --quiet && apt-get install -y \
	git \
    wget \
    zip \
    libicu-dev \
#    locales \
    libpq-dev 

COPY composer-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/composer-setup.sh

#RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
#ENV LANG en_US.UTF-8  
#ENV LANGUAGE en_US:en  
#ENV LC_ALL en_US.UTF-8    

WORKDIR /var/www/

RUN git clone https://framagit.org/framasoft/framadate.git html

WORKDIR /var/www/html

RUN docker-php-ext-install -j$(nproc) json
RUN cp php.ini /usr/local/etc/php/
RUN /usr/local/bin/composer-setup.sh
RUN php composer.phar install
#RUN docker-php-ext-install -j$(nproc) json

VOLUME [ "/var/www/html/app/inc/config.php" ]

EXPOSE 80
