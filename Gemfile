source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.1'
# Use Puma as the app server
#gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
#gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password

gem 'bcrypt-ruby', require: 'bcrypt'

# Use Capistrano for deployment
gem 'capistrano', '3.4.0', require: false
gem 'capistrano-bundler', '1.1.4', require: false
gem 'capistrano-rails', '1.1.6', require: false
gem 'capistrano-passenger', '~> 0.2.0'
gem 'capistrano-rvm', '0.1.2', require: false


# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'rack-attack'
gem 'active_model_serializers', '~> 0.10.0'
gem 'pg'
gem 'activerecord-postgis-adapter', '~> 4.0.0.beta'
gem 'rgeo'
gem 'rgeo-geojson'
gem 'rgeo-activerecord'
gem 'jwt'


group :development, :test, :staging do
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'listen', '~> 3.1.5'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
