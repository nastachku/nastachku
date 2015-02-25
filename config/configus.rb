# encoding: utf-8

Configus.build Rails.env do
  #TODO расширить configus
  credentials_hash = YAML.load(File.read("config/credentials.yml"))

  env :production do

    pagination do
      admin_per_page 50
      audits_per_page 20
    end

    schedule do
      first_day do
        date Time.utc(2015, 4, 10)
        start_time DateTime.new(2015, 4, 10, 9, 0, 0)
        finish_time DateTime.new(2015, 4, 10, 20, 30, 0)
      end
      second_day do
        date Time.utc(2015, 4, 11)
        start_time DateTime.new(2015, 4, 11, 10, 0, 0)
        finish_time DateTime.new(2015, 4, 11, 17, 30, 0)
      end
    end

    mailer do
      default_host "nastachku.ru"
      default_from "noreply@nastachku.ru"
    end

    badges do
      time_to_print_badges DateTime.new(2015, 4, 9, 18, 0, 0)
    end

    token do
      auth_lifetime 24.hour
      old_user_welcome_lifetime 3.month
      remind_password_lifetime 1.hour
    end

    facebook do
      app_id credentials_hash["production"]["facebook"]["app_id"]
      app_secret credentials_hash["production"]["facebook"]["app_secret"]
    end

    twitter do
       key credentials_hash["production"]["twitter"]["key"]
       secret credentials_hash["production"]["twitter"]["secret"]
    end

    cs_cart do
      secret_key credentials_hash["production"]["cs-cart"]["secret_key"]
      enable_auth false
    end

    platidoma do
      host 'pg.platidoma.ru'
    end

    payanyway do
      host 'https://payanyway.ru'
      test_mode 0
    end

    timepad do
      maillist_add_items_url credentials_hash["production"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["production"]["timepad"]["organization_id"]
      maillist_id credentials_hash["production"]["timepad"]["maillist_id"]
      api_key credentials_hash["production"]["timepad"]["api_key"]
    end

  end

  env :development, parent: :production do

    facebook do
      app_id credentials_hash["development"]["facebook"]["app_id"]
      app_secret credentials_hash["development"]["facebook"]["app_secret"]
    end

    cs_cart do
      secret_key credentials_hash["development"]["cs-cart"]["secret_key"]
    end

    platidoma do
      host 'pg-test.platidoma.ru'
    end

    payanyway do
      host 'https://demo.moneta.ru'
      test_mode 0
    end

    timepad do
      maillist_add_items_url credentials_hash["development"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["development"]["timepad"]["organization_id"]
      maillist_id credentials_hash["development"]["timepad"]["maillist_id"]
      api_key credentials_hash["development"]["timepad"]["api_key"]
    end

  end

  env :test, parent: :production do
    platidoma do
      host 'pg-test.platidoma.ru'
    end

    payanyway do
      host 'https://demo.moneta.ru'
      test_mode 0
    end
  end

  env :staging, parent: :production do

    mailer do
      default_host "stg.nastachku.ru"
      default_from "info@stg.nastachku.ru"
    end

    basic_auth do
      username credentials_hash["staging"]["basic_auth"]["username"]
      password credentials_hash["staging"]["basic_auth"]["password"]
    end

    facebook do
      app_id credentials_hash["staging"]["facebook"]["app_id"]
      app_secret credentials_hash["staging"]["facebook"]["app_secret"]
    end

    cs_cart do
      secret_key credentials_hash["staging"]["cs-cart"]["secret_key"]
    end

    platidoma do
      host 'pg-test.platidoma.ru'
    end

    payanyway do
      host 'https://demo.moneta.ru'
      test_mode 0
    end

    timepad do
      maillist_add_items_url credentials_hash["staging"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["staging"]["timepad"]["organization_id"]
      maillist_id credentials_hash["staging"]["timepad"]["maillist_id"]
      api_key credentials_hash["staging"]["timepad"]["api_key"]
    end
  end
end
