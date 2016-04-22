set :stage, :preprod

role :app, %w{deploy@50.50.50.50}
role :web, %w{deploy@50.50.50.50}
role :db,  %w{deploy@50.50.50.50}

server '50.50.50.50', user: 'deploy', roles: %w{web app}#, my_property: :my_value
