#!/usr/bin/env bash
# exit on error
set -o errexit

echo "Starting build process..."

# Install dependencies
echo "Installing dependencies..."
bundle install

# Asset compilation
echo "Compiling assets..."
bundle exec rake assets:precompile

# Database setup
echo "Setting up database..."
RAILS_ENV=production bundle exec rake db:migrate