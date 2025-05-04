#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
RAILS_ENV=production bundle install --without development test

# Clean assets
RAILS_ENV=production bundle exec rake assets:clean

# Precompile assets
RAILS_ENV=production bundle exec rake assets:precompile

# Database setup - only run migrations, skip schema load
RAILS_ENV=production bundle exec rake db:migrate 2>/dev/null || RAILS_ENV=production bundle exec rake db:setup