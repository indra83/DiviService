source 'http://rubygems.org'
ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use postgresql as the database for Active Record
gem 'pg'

gem 'activeadmin',         github: 'gregbell/active_admin' #, branch: 'rails4'
  gem 'devise',              github: 'plataformatec/devise'
  gem 'formtastic',          github: 'justinfrench/formtastic'
  #gem 'ransack'#,             github: 'ernie/ransack', branch: 'rails-4'
gem 'airbrake'
gem 'aws-sdk', '~>1.0'
gem 'bcrypt'
gem 'coffee-rails'
gem 'default_value_for'
gem 'lograge'
gem 'jbuilder', '~> 1.2'
gem 'jquery-rails'
gem 'mini_magick'
gem 'newrelic_rpm'
#gem 'oink'
gem 'paper_trail', '>= 3.0.0.beta1'
gem 'pubnub'
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
