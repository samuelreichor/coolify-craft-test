ARG PHP_VERSION=8.2
FROM php:${PHP_VERSION}-fpm-alpine

WORKDIR /app

# Installiere Systemabhängigkeiten für PHP-Erweiterungen
# (imagemagick für Bildmanipulation, optional aber oft nützlich)
RUN apk update && apk add --no-cache \
    git \
    curl

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