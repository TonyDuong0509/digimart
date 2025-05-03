#!/bin/sh
# Chạy lệnh chown để chuyển quyền sở hữu thư mục /var/www/html cho user www-data
git config --global --add safe.directory /var/www/html
mkdir -p /var/www/html/bootstrap/cache
mkdir -p /var/www/html/storage/framework/cache
mkdir -p /var/www/html/storage/framework/views
mkdir -p /var/www/html/storage/framework/sessions
mkdir -p /var/www/html/storage/app/public
mkdir -p /var/www/html/storage/logs
chown -R www-data:www-data /var/www/html

# Chạy composer migrate và chạy optimize
cd /var/www/html
COMPOSER_PROCESS_TIMEOUT=0 composer install
composer require laravel/breeze --dev
php artisan key:generate
php artisan storage:link
php artisan breeze:install blade
php artisan migrate
php artisan cache:clear && php artisan view:clear && php artisan optimize && php artisan queue:restart

# Vite install
npm install && npm run build

supervisord -c /etc/supervisor/supervisord.conf
