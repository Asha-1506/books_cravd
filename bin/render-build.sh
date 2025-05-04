#!/usr/bin/env bash
# exit on error
set -o errexit

export BUNDLE_DEPLOYMENT=false
export BUNDLE_PATH=vendor/bundle
export BUNDLE_WITHOUT="development:test"

# Install gems
bundle check || bundle install

# Clean and precompile assets
RAILS_ENV=production bundle exec rake assets:clean
RAILS_ENV=production bundle exec rake assets:precompile

# Set up database
RAILS_ENV=production bundle exec rake db:migrate