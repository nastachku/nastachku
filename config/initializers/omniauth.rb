Rails.application.config.middleware.use OmniAuth::Builder do

  provider :facebook, 
    configus.facebook.app_id, 
    configus.facebook.app_secret

  provider :twitter,
    configus.twitter.key,
    configus.twitter.secret
    
end