# config valid only for Capistrano 3.1
lock '3.3.5'

set :application, 'groupmates'

set :repo_url, 'git@bitbucket.org:tquiroga/groupmates.git'

set :branch, 'dev'
#set :branch, fetch(:branch, 'dev')

# Default branch is :master
#ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/deploy/groupmates'

# Default value for :scm is :git
set :scm, :git
set :user, "deploy"

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
#set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc "Setup filesystem for uploads"
  task :setup_uploads do
    on roles(:app) do
      execute "mkdir -p #{release_path}/public/uploads/users"
      execute "mkdir -p #{release_path}/public/uploads/projects"
      execute "chmod -R 777 #{release_path}/public/uploads"
   end
  end

  desc "build missing paperclip styles"
  task :build_missing_paperclip_styles do
    on roles(:app) do
      execute "cd #{current_path}; rake paperclip:refresh:missing_styles RAILS_ENV=production"
    end
  end

  desc "Seed data to the db"
  task :seed do
    on roles(:app) do
      execute "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=production"
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
  after :deploy, 'deploy:setup_uploads'
  #after :deploy, 'deploy:seed'
  #after :deploy, "deploy:build_missing_paperclip_styles"

end

namespace :custom do
  task :task do
    run "cd #{current_path} && bundle exec rake db:reset RAILS_ENV=#{rails_env} && echo 'Refresing styles'"
  end
end
