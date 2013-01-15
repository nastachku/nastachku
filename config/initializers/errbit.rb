
Airbrake.configure do |config|
  config.api_key = '8b382fb515e1d4f83ef9e459cad00c40'
  config.host    = 'errbit.undev.cc'
  config.port    = 80
  config.secure  = config.port == 443   
end
