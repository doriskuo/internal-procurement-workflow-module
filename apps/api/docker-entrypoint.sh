#!/bin/sh
set -e

echo "Waiting for MySQL database connection..."
until npx prisma db push --schema=/app/prisma/schema.prisma --skip-generate; do
  echo "MySQL is not ready yet, retrying in 3 seconds..."
  sleep 3
done

echo "Database schema synchronized successfully."
echo "Seeding initial mock data..."
npx tsx /app/prisma/seed.ts || true

echo "Starting NestJS application..."
exec node dist/main
