#!/usr/bin/env bash
set -o errexit

# Install dependencies
bundle install

# Asset compilation
bundle exec rake assets:precompile

# Database setup
bundle exec rake db:migrate