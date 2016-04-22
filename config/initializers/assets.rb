# Stylesheets

Rails.application.config.assets.precompile += %w( home.css )
Rails.application.config.assets.precompile += %w( user.css )
Rails.application.config.assets.precompile += %w( groupmates.css )

# Javascripts

Rails.application.config.assets.precompile += %w( home.js )
Rails.application.config.assets.precompile += %w( application/cookie_consent.js )
Rails.application.config.assets.precompile += %w( user.js )
Rails.application.config.assets.precompile += %w( groupmates.js )
