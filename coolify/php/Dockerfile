ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm-alpine

WORKDIR /app

# Installiere Systemabhängigkeiten für PHP-Erweiterungen
# (imagemagick für Bildmanipulation, optional aber oft nützlich)
RUN apk update && apk add --no-cache \
    # Für DB (pgsql oder mysql)
    postgresql-dev \
    # mysql-client \ # Nur wenn MySQL/MariaDB verwendet wird
    # Für Bilder (gd und/oder imagick)
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    imagemagick-dev \
    imagemagick \
    # Für Intl
    icu-dev \
    # Für Zip Archive
    zip \
    unzip \
    libzip-dev \
    # Weitere nützliche Tools
    git \
    curl \
    && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        gd \
        intl \
        opcache \
        pdo \
        pdo_pgsql \      # oder pdo_mysql
        zip \
    # Räume Build-Abhängigkeiten auf
    && apk del .build-deps

# Installiere Composer global
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Kopiere zuerst nur die Composer-Dateien
COPY composer.json composer.lock* ./

# Installiere Composer-Abhängigkeiten (ohne Dev-Pakete, optimiert für Production)
# --prefer-dist bevorzugt stabile Distributionen, --no-progress spart Log-Output
# Der --no-scripts Teil ist optional, falls Scripte Probleme machen
RUN composer install --prefer-dist --no-dev --no-interaction --no-progress --optimize-autoloader \
    && composer clear-cache

# Kopiere den restlichen Applikationscode
COPY . .

# Stelle sicher, dass die notwendigen Ordner beschreibbar sind durch den Webserver-Benutzer (www-data)
# Wichtig, *nachdem* der Code kopiert wurde
RUN mkdir -p storage config/project && \
    chown -R www-data:www-data storage config && \
    chmod -R 775 storage config

# PHP Konfigurations-Overrides (optional)
# Kann auch über Umgebungsvariablen im docker-compose.yaml gesetzt werden
# COPY php/php-override.ini /usr/local/etc/php/conf.d/99-override.ini

# Wechsle zum non-root User
USER www-data

# Standard-Kommando (wird von der Basis-Image geerbt, aber zur Klarheit hier)
# CMD ["php-fpm"]

# Exponiere den PHP-FPM Port (für interne Kommunikation mit Nginx)
EXPOSE 9000