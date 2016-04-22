require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Groupmates
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.autoload_paths += %W(#{config.root}/lib)
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.paths << Emoji.images_path
    config.assets.precompile << "emoji/**/*.png"

    config.assets.enabled = true
    #Needs to be false on Heroku
    config.assets.initialize_on_precompile = true
    config.static_cache_control = "public, max-age=31536000"

    #404 and 500 handling
    config.exceptions_app = self.routes
    config.active_record.raise_in_transactional_callbacks = true
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
