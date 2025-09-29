#!/bin/bash

echo "🚀 Setting up PROMON Production Monitoring System..."

# Update system
sudo apt-get update -qq

# Install PostgreSQL
echo "📦 Installing PostgreSQL..."
sudo apt-get install -y postgresql postgresql-contrib > /dev/null 2>&1

# Start PostgreSQL
sudo service postgresql start
sleep 2

# Create database
echo "🗄️ Setting up database..."
sudo -u postgres psql -c "CREATE DATABASE promon_db;" 2>/dev/null || true
sudo -u postgres psql -c "CREATE USER promon_user WITH PASSWORD 'promon_pass';" 2>/dev/null || true
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE promon_db TO promon_user;"
sudo -u postgres psql -c "ALTER DATABASE promon_db OWNER TO promon_user;"

# Install global packages
echo "📦 Installing npm packages..."
npm install -g concurrently nodemon > /dev/null 2>&1

echo ""
echo "✅ PROMON Setup Complete!"
echo "Run: npm run setup"
