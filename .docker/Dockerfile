FROM php:8.3-fpm

# Install required extensions and packages
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    wget \
    supervisor \
    cron \
    nano \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl gd bcmath \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /var/www/html

# Install Composer
RUN wget https://getcomposer.org/installer -O composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm composer-setup.php
ENV COMPOSER_ALLOW_SUPERUSER=1

# # Đặt quyền cho các thư mục storage và cache & start script
COPY ../.docker/runner.sh /usr/local/bin/runner.sh
RUN chmod +x /usr/local/bin/runner.sh

### Supervisord
COPY ../.docker/supervisord.conf /etc/supervisor/conf.d/worker.conf
RUN mkdir -p /var/log/supervisor
RUN touch /var/log/supervisor/supervisord.log
RUN chown -R www-data:www-data /var/log/supervisor

### Cronjob
COPY ../.docker/cronjob /etc/cron.d/laravel-cron
RUN chmod 0644 /etc/cron.d/laravel-cron
RUN crontab /etc/cron.d/laravel-cron
RUN touch /var/log/cron.log


# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_current.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


# Expose port 9000 for PHP-FPM
EXPOSE 9000
CMD /usr/local/bin/runner.sh