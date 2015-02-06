Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,
    configus.facebook.app_id,
    configus.facebook.app_secret

  provider :vkontakte,
    Rails.application.secrets.vk_app_id,
    Rails.application.secrets.vk_secure_key,
    { scope: 'email' }

  provider :twitter,
    configus.twitter.key,
    configus.twitter.secret,
    { use_authorize: true }
end
