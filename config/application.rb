require File.expand_path('../boot', __FILE__)

# https://github.com/activerecord-hackery/ransack/pull/341
ENV['RANSACK_FORM_BUILDER'] = '::SimpleForm::FormBuilder'

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups)
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module Nastachku
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    config.autoload_paths += Dir["#{config.root}/lib/**/", "#{config.root}/app/models/ckeditor"]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Yerevan' #'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true
    config.action_view.sanitized_allowed_tags = 'p', 'strong', 'ul', 'li'
    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enforce whitelist mode for mass assignment.
    # This will create an empty whitelist of attributes available for mass-assignment for all models
    # in your app. As such, your models will need to explicitly whitelist or blacklist accessible
    # parameters by using an attr_accessible or attr_protected declaration.
    config.active_record.whitelist_attributes = true

    config.active_record.raise_in_transactional_callbacks = true

    ActionMailer::Base.default charset: "UTF-8"

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'
    config.assets.precompile += %w( promo.js )

    config.generators do |g|
      g.template_engine :haml
      g.test_framework  :test_unit, :fixture => true, :fixture_replacement => :factory_girl
      g.stylesheets false
      g.javascripts false
    end

    # catch 404/500 errors
    config.exceptions_app = self.routes

    config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
      r301 '/reporters.html', 'http://2012.nastachku.ru/reporters.html'
      r301 '/vote-comment.html', 'http://2012.nastachku.ru/'
      r301 '/day-zero.html', 'http://2012.nastachku.ru/'
      r301 '/participants.html', 'http://2012.nastachku.ru/'
      r301 '/sponsors.html', 'http://2012.nastachku.ru/sponsors.html'
      r301 '/site-news.html', 'http://2012.nastachku.ru/site-news.html'
      r301 '/program.html-ru', 'http://2012.nastachku.ru/'
      r301 '/contacts.html', 'http://2012.nastachku.ru/'
      r301 '/community.html-ru', 'http://2012.nastachku.ru/community.html-ru'
      r301 '/banners.html', 'http://2012.nastachku.ru/banners.html'
      r301 '/accreditation.html', 'http://2012.nastachku.ru/accreditation.html'
      r301 '/user/new', 'http://nastachku.ru/users/new'
      r301 '/user_events', 'http://nastachku.ru/user_lectures'
      r301 '/events', 'http://nastachku.ru/lectures'
    end
  end
end
