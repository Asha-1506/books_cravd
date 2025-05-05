#!/usr/bin/env bash
set -o errexit

export RAILS_ENV=production
export RACK_ENV=production

# Install dependencies
bundle config set --local deployment 'true'
bundle config set --local without 'development test'
bundle install

# Asset compilation
bundle exec rake assets:clean
bundle exec rake assets:precompile

# Database setup
bundle exec rake db:migrate