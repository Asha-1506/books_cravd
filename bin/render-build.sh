#!/usr/bin/env bash
set -o errexit

# Install dependencies
bundle install

# Database setup
bundle exec rake db:migrate

# Asset compilation
bundle exec rake assets:precompile