FROM php:7.3.6-fpm-alpine3.9

RUN wget https://getcomposer.org/composer.phar
RUN chmod +x ./composer.phar
RUN mv ./composer.phar /usr/bin/composer
WORKDIR /var/www
RUN rm -rf /var/www/html
RUN composer create-project laravel/laravel
RUN cp -a laravel/* .
# RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN ln -s public html

RUN apk add --no-cache openssl bash mysql-client nodejs npm
RUN docker-php-ext-install pdo pdo_mysql

# ENV DOCKERIZE_VERSION v0.6.1
# RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
#     && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
#     && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz






# COPY . /var/www
# WORKDIR /var/www/laravel
# RUN     php artisan key:generate && \
#            php artisan config:cache

EXPOSE 9000
ENTRYPOINT ["php-fpm"]