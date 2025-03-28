ARG PHP_VERSION=8.2
FROM jkaninda/nginx-php-fpm:${PHP_VERSION}

WORKDIR /app

USER root

# Composer installieren
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Composer dependencies
COPY composer.json composer.lock* ./
RUN composer install --prefer-dist --no-dev --no-interaction --no-progress --optimize-autoloader \
    && composer clear-cache

# App-Code kopieren
COPY --chown=www-data:www-data . .

# Speicher-Verzeichnis vorbereiten
RUN mkdir -p storage && \
    chown -R www-data:www-data storage && \
    chmod -R 775 storage

# Jetzt als www-data weiterarbeiten
USER www-data

EXPOSE 9000
