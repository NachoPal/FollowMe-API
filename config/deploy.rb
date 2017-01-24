set :application, 'follow_me_api'
set :repo_url, 'git@example.com:me/my_repo.git'

set :deploy_to, '/home/deploy/follow_me_api'

append :linked_files, 'config/database.yml', 'config/secrets.yml'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads'