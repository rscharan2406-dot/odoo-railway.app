#!/bin/sh
set -e

echo "Waiting for PostgreSQL..."
while ! nc -z $ODOO_DB_HOST $ODOO_DB_PORT; do
  sleep 1
done

echo "Starting Odoo..."
exec odoo \
  --db_host=$ODOO_DB_HOST \
  --db_port=$ODOO_DB_PORT \
  --db_user=$ODOO_DB_USER \
  --db_password=$ODOO_DB_PASSWORD \
  --db_name=$ODOO_DB_NAME \
  --http-port=$PORT
