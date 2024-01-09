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

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR="/tmp/mysql_backup"

mkdir -p "$BACKUP_DIR"
mysqldump -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" "$DB_NAME" > "$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql"

gzip "$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql"
aws s3 --endpoint-url "$S3_ENDPOINT" cp "$BACKUP_DIR/$DB_NAME-$TIMESTAMP.sql.gz" "s3://$S3_BUCKET/$S3_PATH/"

rm -rf "$BACKUP_DIR"

echo "Backup completed"
