source "https://rubygems.org"
ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.0"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.5"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft", "~> 0.8"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails", "~> 2.1"

# Turbolinks makes navigating your web application faster
gem "turbo-rails", "~> 1.5"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails", "~> 1.3"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder", "~> 2.11"

# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use Active Storage for file uploads
gem "image_processing", "~> 1.2"

# Authentication
gem "devise"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Asset compilation dependencies
gem "terser"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 5.0"

# Explicit logger dependency
gem "logger", "~> 1.7"

# Heroku integration
gem "rails_12factor", group: :production

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "sqlite3", "~> 1.4"
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
