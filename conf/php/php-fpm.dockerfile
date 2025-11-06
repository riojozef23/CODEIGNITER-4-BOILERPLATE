# Use the official PHP 8.1 FPM base image
FROM php:8.1-fpm

# Set the working directory inside the container
WORKDIR /var/www/html/

# Copy only composer.json first to cache dependencies layer
COPY ./../src/app_ci/composer.json ./

# Custom Dependencies and required PHP extensions
RUN apt-get update -y && apt-get install -y \
    curl \
    gettext \
    libfreetype6-dev \
    libicu-dev \
    libjpeg-dev \
    libjpeg62-turbo-dev \
    libmariadb-dev \
    libmcrypt-dev \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    make \
    netcat-traditional \
    openssl \
    unzip \
    && rm -rf /var/lib/apt/lists/* \
    \
    # Configure and install PHP extensions
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
        mysqli \
        gettext \
        pdo \
        pdo_mysql \
        intl \
        zip \
    && docker-php-ext-enable mysqli \
    \
    # Composer Installation Global
    && curl -sS https://getcomposer.org/installer | php -- \
        --install-dir=/usr/bin --filename=composer

COPY --chown=www-data:www-data ./../src/app_ci/ ./

# Set necessary permissions and run composer
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 writable \
    && chmod -R 775 writable/cache \
    && chmod -R 775 writable/debugbar \
    && chmod -R 775 writable/logs \
    && chmod -R 775 writable/session \
    && chmod -R 775 writable/uploads \
    \
    # RUn composer install and update
    && COMPOSER_CONNECT_TIMEOUT=300 \
       COMPOSER_PROCESS_TIMEOUT=300 \
       COMPOSER_ALLOW_SUPERUSER=1 \
       composer update \
         --no-interaction \
         --optimize-autoloader \
    && COMPOSER_CONNECT_TIMEOUT=300 \
       COMPOSER_PROCESS_TIMEOUT=300 \
       COMPOSER_ALLOW_SUPERUSER=1 \
       composer install \
         --no-interaction \
         --optimize-autoloader \
    \
    && chown -R www-data:www-data /var/www/html

# Copy custom php.ini (This will be copied into the FPM configuration directory)
COPY ./../conf/php/php.ini /usr/local/etc/php/conf.d/custom.ini

# PHP-FPM runs on port 9000 by default (no need to EXPOSE it here)

# No ENTRYPOINT or CMD as this is FPM, which has its own default CMD.