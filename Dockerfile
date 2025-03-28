ARG PHP_VERSION=8.2
FROM ghcr.io/craftcms/image:${PHP_VERSION}

WORKDIR /app

# Composer installieren
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Composer dependencies
COPY composer.json composer.lock* ./
RUN composer install --prefer-dist --no-dev --no-interaction --no-progress --optimize-autoloader \
    && composer clear-cache

# App-Code kopieren mit richtiger Ownership
COPY --chown=www-data:www-data . .

# Nur storage beschreibbar machen
RUN mkdir -p storage && \
    chown -R www-data:www-data storage && \
    chmod -R 775 storage

USER www-data

EXPOSE 9000
