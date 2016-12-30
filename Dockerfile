FROM php:apache

RUN apt-get update --quiet && apt-get install -y \
    git \
    wget \
    zip \
    libicu-dev \
    libpq-dev \
    zlib1g-dev \
    libicu-dev

#install composer setup script
COPY composer-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/composer-setup.sh

#install internationalization libs
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

RUN docker-php-ext-install pdo pdo_pgsql

WORKDIR /var/www/
RUN git clone https://framagit.org/framasoft/framadate.git html

WORKDIR /var/www/html
RUN docker-php-ext-install -j$(nproc) json
RUN cp php.ini /usr/local/etc/php/

#Setup composer deps
RUN /usr/local/bin/composer-setup.sh
RUN php composer.phar install

VOLUME [ "/var/www/html/app/inc/config.php" ]

EXPOSE 80
