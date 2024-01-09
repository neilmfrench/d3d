#!/bin/bash

# Database configuration
DB_HOST="..."
DB_USER="..."
DB_PASSWORD="..."
DB_NAME="..."

# S3-compatible storage configuration
S3_ENDPOINT="..."
S3_ACCESS_KEY="..."
S3_SECRET_KEY="..."
S3_BUCKET="..."
S3_PATH="..."

RESTORE_DIR="/tmp/mysql_restore"

mkdir -p "$RESTORE_DIR"

latest_backup=$(aws s3 --endpoint-url "$S3_ENDPOINT" ls "s3://$S3_BUCKET/$S3_PATH/" | sort -r | head -n 1 | awk '{print $4}')
aws s3 --endpoint-url "$S3_ENDPOINT" cp "s3://$S3_BUCKET/$S3_PATH/$latest_backup" "$RESTORE_DIR/$latest_backup"

gzip -d "$RESTORE_DIR/$latest_backup"

mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" < "$RESTORE_DIR/${latest_backup%.gz}"

rm -rf "$RESTORE_DIR"

echo "Restore complete"
