Groupmates::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = { :host => '127.0.0.1:3000' }
  config.action_mailer.perform_deliveries = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log
  config.log_level = :error

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load
  config.active_record.raise_in_transactional_callbacks = true

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true
  config.colorize_logging = true

  config.x.pusher_app_id = ENV["pusher_app_id"]
  config.x.pusher_api_key = ENV["pusher_api_key"]
  config.x.pusher_api_secret = ENV["pusher_api_secret"]

  config.middleware.use 'Rack::Insight::App', :secret_key => '&kKYK+^U2n=wesh'

  # --- Logstash ---

  # Enable the logstasher logs for the current environment
  config.logstasher.enabled = true

  # This line is optional if you do not want to suppress app logs in your <environment>.log
  config.logstasher.suppress_app_log = false

  # This line is optional, it allows you to set a custom value for the @source field of the log event
  #config.logstasher.source = 'your.arbitrary.source'

  # This line is optional if you do not want to log the backtrace of exceptions
  #config.logstasher.backtrace = false

  # This line is optional, defaults to log/logstasher_<environment>.log
  #config.logstasher.logger_path = 'log/logstasher.log'

end
