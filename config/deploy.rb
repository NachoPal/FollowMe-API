application = 'follow_me_api'

set :application, application
set :repo_url, 'git@github.com:NachoPal/FollowMe-API.git'
set :branch, :staging
set :deploy_to, "/home/deploy/#{application}"

#append :linked_files, 'config/database.yml', 'config/secrets.yml'
#append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'