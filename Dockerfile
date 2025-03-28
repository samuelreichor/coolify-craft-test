ARG PHP_VERSION=8.2
FROM ghcr.io/craftcms/image:${PHP_VERSION}

WORKDIR /app
USER root

# Composer installieren
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Composer dependencies
COPY composer.json composer.lock* ./
RUN composer install --prefer-dist --no-dev --no-interaction --no-progress --optimize-autoloader \
    && composer clear-cache

# App-Code kopieren mit richtiger Ownership
COPY --chown=root:root . .

# Nur storage beschreibbar machen
RUN mkdir -p storage && \
    chown -R root:root storage && \
    chmod -R 775 storage



EXPOSE 9000
