#!/bin/bash
PORT=8000
HOST=localhost

PORT_AVAILABLE=$(lsof -i:$PORT)

if [[ ! -z "$PORT_AVAILABLE" ]]
then
	# Killing the port if any process is using the same port....
	# fuser -k $PORT/tcp

    echo "Error:: Port ${PORT} is already in use. Please kill the port manually & re-run the script"
	exit 0
fi


echo "> Linking local env if not linked yet...."
ln -s .env.local .env

echo "> Installing composer dependencies..."
alias composer='XDEBUG_MODE=off \composer'
composer install;

echo "> Clearing all cache - Route/Views/Config..."
php artisan cache:clear;

echo "> Migrating database if available..."
php artisan migrate;

echo "> Serving the project at configured port & host...."
php artisan serve --host=$HOST --port=$PORT;