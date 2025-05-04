#!/usr/bin/env bash
# exit on error
set -o errexit

# Clear bundler environment
unset BUNDLE_PATH
unset BUNDLE_BIN

# Install latest bundler
gem update --system
gem install bundler -v '2.4.22'

# Install gems
bundle config set --local without 'development test'
bundle install

# Clean and precompile assets
bundle exec rake assets:clean
bundle exec rake assets:precompile

# Set up database
bundle exec rake db:migrate