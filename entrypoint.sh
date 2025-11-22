#!/bin/sh
set -e

echo "Waiting for PostgreSQL..."
while ! nc -z "$ODOO_DB_HOST" "$ODOO_DB_PORT"; do
  sleep 1
done
echo "Database is reachable!"

# Create config directory
mkdir -p /etc/odoo

# Create odoo.conf dynamically
CONF_PATH="/etc/odoo/odoo.conf"

cat > "$CONF_PATH" <<EOF
[options]
admin_passwd = ${ODOO_ADMIN_PASSWD}
db_host = ${ODOO_DB_HOST}
db_port = ${ODOO_DB_PORT}
db_user = ${ODOO_DB_USER}
db_password = ${ODOO_DB_PASSWORD}
data_dir = /var/lib/odoo
EOF

echo "Starting Odoo with base initialization if needed..."

# Run Odoo and install base if DB is empty
exec odoo \
  -i base \
  --config="$CONF_PATH" \
  --http-port=${PORT:-8000} \
  --proxy-mode
