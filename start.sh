#!/bin/sh

set -e
/usr/sbin/php5-fpm --daemonize --fpm-config /etc/php5/fpm/php-fpm.conf
exec /usr/sbin/nginx
