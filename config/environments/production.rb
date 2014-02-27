Nastachku::Application.configure do
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = true
  config.assets.compress = true
  config.assets.compile = true
  config.assets.digest = true
  config.assets.precompile += %w( ckeditor/* )
  config.assets.precompile += %w( web/application.js web/application.css admin/application.js admin/application.css *.ttf *.svg *.eot *woff )
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  GA.tracker = "UA-38587983-1"
  ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
end
