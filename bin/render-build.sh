#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Starting build process..."

echo "RAILS_ENV: $RAILS_ENV"
echo "DATABASE_URL: $DATABASE_URL"
echo "RUBY_VERSION: $RUBY_VERSION"

# Install dependencies
echo "Installing dependencies..."
bundle install

# Asset compilation
echo "Compiling assets..."
bundle exec rake assets:precompile

# Database setup
echo "Setting up database..."
bundle exec rake db:migrate:status || bundle exec rake db:create
bundle exec rake db:migrate