#!/usr/bin/env bash
# exit on error
set -o errexit

# Configure bundler
bundle config set --local deployment 'false'
bundle config set --local frozen 'false'

# Install dependencies
RAILS_ENV=production bundle install

# Clean assets
RAILS_ENV=production bundle exec rake assets:clean

# Precompile assets
RAILS_ENV=production bundle exec rake assets:precompile

# Database setup - only run migrations, skip schema load
RAILS_ENV=production bundle exec rake db:migrate 2>/dev/null || RAILS_ENV=production bundle exec rake db:setup