FROM serversideup/php:8.2-fpm-nginx

ENV PHP_OPCACHE_ENABLE=1

USER root

# PHP-Erweiterungen installieren
RUN apt-get update && apt-get install -y \
    libicu-dev \
    nodejs \
    unzip \
    git \
    && docker-php-ext-install bcmath intl

# Node installieren (optional, falls nicht im Image enthalten)
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# Code ins Image kopieren
COPY --chown=www-data:www-data . /var/www/html

USER www-data

# Frontend-Tools und Composer
RUN npm install
RUN npm run build

RUN composer install --no-interaction --optimize-autoloader --no-dev
