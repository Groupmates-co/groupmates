Groupmates::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.action_mailer.default_url_options = { :host => 'groupmates.co' }
  # ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.smtp_settings = {
    :address   => "smtp.mandrillapp.com",
    :port      => 587, # ports 587 and 2525 are also supported with STARTTLS
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => ENV["mandrill_username"],
    :password  => ENV["mandrill_password"], # SMTP password is any valid API key
    :authentication => 'login', # Mandrill supports 'plain' or 'login'
    :domain => 'groupmates.co', # your domain to identify your server when connecting
  }

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both thread web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rack::Cache to put a simple HTTP cache in front of your application
  # Add `rack-cache` to your Gemfile before enabling this.
  # For large-scale production use, consider using a caching reverse proxy like nginx, varnish or squid.
  # config.action_dispatch.rack_cache = true

  # Disable Rails's static asset server (Apache or nginx will already do this).
  config.serve_static_files = true

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = true
  config.assets.initialize_on_precompile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = '1.6'

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = false

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups.
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.action_controller.asset_host = "http://assets.example.com"
  #asset_sync_config_file = File.join(Rails.root, 'config', 'asset_sync.yml')
  AssetSync.configure do |config|
    config.fog_provider = 'AWS'
    config.fog_directory = ENV["aws_bucket"]
    config.aws_access_key_id = ENV["aws_access_key_id"]
    config.aws_secret_access_key = ENV["aws_secret_access_key"]
    # Don't delete files from the store
    config.existing_remote_files = 'keep'
    # Increase upload performance by configuring your region
    config.fog_region = 'eu-west-1'
    # Automatically replace files with their equivalent gzip compressed version
    config.gzip_compression = true
  end
  # ASSETCONFIG = HashWithIndifferentAccess.new(YAML::load(IO.read(asset_sync_config_file)))[Rails.env]
  # ASSETCONFIG.each do |k,v|
  #   ENV[k.upcase] ||= v
  # end

  config.assets.enabled = true
  #config.action_controller.asset_host = "//#{ENV['FOG_DIRECTORY']}.s3.amazonaws.com"
  #config.action_controller.asset_host = "//static.groupmates.co"

  # Precompile additional assets.
  # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
  # config.assets.precompile += %w( search.js )
  config.assets.precompile += ['application.css', 'home.css', 'user.css', 'groupmates.css']
  config.assets.precompile += ['application.js', 'home.js', 'user.js', 'groupmates.js']
  #config.assets.precompile << /app/assets/*\.(?:jpg|jpeg|png|gif|js|css|eof|ttf|wott|svg|otf)\z/
  #config.assets.precompile << /\.(?:jpg|jpeg|png|gif|js|css|eof|ttf|wott|svg|otf)\z/
  #config.assets.paths << Rails.root.join("app", "assets", "fonts")
  config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  # config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found).
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Disable automatic flushing of the log to improve performance.
  # config.autoflush_log = false

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  Paperclip.options[:command_path] = "/usr/bin/convert"
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV["aws_bucket"],
      :access_key_id => ENV["aws_access_key_id"],
      :secret_access_key => ENV["aws_secret_access_key"]
    }
  }
end
