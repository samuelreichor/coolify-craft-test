ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm-alpine

WORKDIR /app

RUN apk update && apk add --no-cache \
    git \
    curl \
    libzip-dev \
    libpng-dev \
    icu-dev \
    zlib-dev \
    unzip \
    oniguruma-dev \
    && docker-php-ext-install pdo pdo_mysql intl zip

# Composer installieren
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Composer files zuerst (für besseren Cache)
COPY composer.json composer.lock* ./

RUN composer install --prefer-dist --no-dev --no-interaction --no-progress --optimize-autoloader \
    && composer clear-cache

# Jetzt den restlichen Code
COPY . .

# Schreibrechte für Craft
RUN mkdir -p storage config/project && \
    chown -R www-data:www-data storage config && \
    chmod -R 775 storage config

USER www-data

EXPOSE 9000
