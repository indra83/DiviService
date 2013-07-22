source 'https://rubygems.org'
ruby '2.0.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use postgresql as the database for Active Record
gem 'pg'

gem 'activeadmin',         github: 'gregbell/active_admin', branch: 'rails4'
  gem 'devise',              github: 'plataformatec/devise'
  gem 'formtastic',          github: 'justinfrench/formtastic'
  gem 'ransack',             github: 'ernie/ransack', branch: 'rails-4'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jbuilder', '~> 1.2'
gem 'jquery-rails'
gem 'inherited_resources', github: 'josevalim/inherited_resources'
  gem 'responders',          github: 'plataformatec/responders'
gem 'sass-rails', '~> 4.0.0'
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'
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
    gem 'libnotify'
    gem 'rb-inotify'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'guard-unicorn'
  gem 'hirb'
  gem 'json_expressions'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :production do # Heroku
  gem 'rails_12factor'
end
