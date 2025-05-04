#!/usr/bin/env bash
# exit on error
set -o errexit

# Install dependencies
bundle install

# Set up database
bundle exec rake db:schema:load
bundle exec rake db:migrate

# Precompile assets
bundle exec rake assets:precompile
bundle exec rake assets:clean