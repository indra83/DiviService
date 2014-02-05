Airbrake.configure do |config|
  config.api_key = ENV['ERRBIT_TOKEN']
  config.host    = 'divi-errors.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end
