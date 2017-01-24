set :repo_url, 'git@github.com:NachoPal/FollowMe-API.git'
set :scm, :git
set :format, :pretty
set :keep_releases, 5
set :use_sudo, false

# # Capistrano bundler
set :bundle_path, nil
set :bundle_binstubs, nil
set :bundle_without, %w{development test}.join(' ')
set :bundle_flags, '--deployment --quiet'

task :app_log_dir do
  on roles(:all) do
    # change the log directory symlink
    execute  "cd #{release_path} && rm -rf log && ln -s /var/log/follow_me/application log"
    execute  "cd #{shared_path} && rm -rf log && ln -s /var/log/follow_me/application log"
  end
end

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute "mkdir -p #{release_path.join('tmp')}"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after 'deploy:updating', 'app_log_dir'
  after 'deploy:publishing', 'deploy:restart'
end

#append :linked_files, 'config/database.yml', 'config/secrets.yml'
#append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'