#!/usr/bin/env bash
# exit on error
set -o errexit

# Remove Gemfile.lock and install gems from scratch
rm -f Gemfile.lock
gem install bundler
bundle install

# Clean and precompile assets
bundle exec rake assets:clean
bundle exec rake assets:precompile

# Set up database
bundle exec rake db:migrate