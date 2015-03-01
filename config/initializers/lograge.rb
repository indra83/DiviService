Rails.application.configure do
  config.lograge.enabled = true
  #config.lograge.formatter =  Lograge::Formatters::Json.new
  config.lograge.custom_options = lambda do |event|
    {
      params: event.payload[:params].except('conroller', 'action', 'format')
    }
  end
end
