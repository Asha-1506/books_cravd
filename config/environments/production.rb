require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot for better performance and memory savings (ignored by Rake tasks).
  config.eager_load = true

  # Full error reports are disabled.
  config.consider_all_requests_local = false

  # Enable server timing
  config.server_timing = true

  # Enable caching
  config.action_controller.perform_caching = true
  config.cache_store = :memory_store

  # Ensures that a master key has been made available in ENV["RAILS_MASTER_KEY"]
  config.require_master_key = true

  # Disable serving static files from `public/`, relying on NGINX/Apache to do so instead
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  config.action_dispatch.x_sendfile_header = nil

  # Include generic and useful information about system operation, but avoid logging too much
  # information to avoid inadvertent exposure of personally identifiable information (PII).
  config.log_level = :info

  # Prepend all log lines with the following tags.
  config.log_tags = [ :request_id ]

  # Use a different logger for distributed setups.
  config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  # Don't log any deprecations.
  config.active_support.report_deprecations = false

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Enable DNS rebinding protection
  config.hosts << ENV['RENDER_EXTERNAL_HOSTNAME'] if ENV['RENDER_EXTERNAL_HOSTNAME'].present?
end
