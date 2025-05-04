#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Clean assets
bundle exec rake assets:clean

# Precompile assets
bundle exec rake assets:precompile

# Database setup - only run migrations, skip schema load
bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup