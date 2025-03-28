FROM php:8.2.27-fpm

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
WORKDIR /app