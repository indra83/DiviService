# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Load heroku vars from local file
heroku_env = File.expand_path('../heroku_env.rb', __FILE__)

load heroku_env if File.exists? heroku_env
