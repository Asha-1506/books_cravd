#!/usr/bin/env bash
# exit on error
set -o errexit

# Install specific Ruby version
curl -sSL https://get.rvm.io | bash -s stable
source /etc/profile.d/rvm.sh
rvm install 3.2.2
rvm use 3.2.2 --default

# Install bundler
gem install bundler -v 2.4.22

# Install dependencies
bundle install

# Asset compilation
bundle exec rake assets:precompile

# Database setup
bundle exec rake db:migrate