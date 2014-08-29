source 'http://rubygems.org'
ruby '2.1.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.1'

# Use postgresql as the database for Active Record
gem 'pg'

gem 'airbrake'
gem 'bcrypt'
gem 'default_value_for'
gem 'jbuilder', '~> 1.2'
gem 'inherited_resources', github: 'josevalim/inherited_resources'
  gem 'responders',          github: 'plataformatec/responders'
gem 'newrelic_rpm'
gem 'oink'
gem 'paper_trail', '>= 3.0.0.beta1'
gem 'pubnub'
gem 'unicorn'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem "factory_girl_rails", "~> 4.0"
  gem 'foreman'
  gem 'guard'
    gem 'libnotify' if /linux/ =~ RUBY_PLATFORM
    gem 'rb-inotify' if /linux/ =~ RUBY_PLATFORM
    gem 'growl' if /darwin/ =~ RUBY_PLATFORM
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-unicorn'
  gem 'hirb'
  gem 'json_expressions'
# gem 'localtunnel'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'rspec-its'
end

group :production do # Heroku
  gem 'rails_12factor'
end

group :development do
  gem 'heroku_san'
  gem 'spring'
end
