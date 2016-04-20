# encoding: utf-8

Configus.build Rails.env do
  #TODO расширить configus
  credentials_hash = YAML.load(File.read("config/credentials.yml"))

  env :production do
    redis_host 'localhost'

    analytics do
      host 'nastachku.ru'
    end

    move_to_top_count 10

    now_time -> {Time.zone.now}

    pagination do
      admin_per_page 50
      audits_per_page 20
    end

    schedule do
      first_day do
        date Time.utc(2016, 4, 22)
        start_time DateTime.new(2016, 4, 22, 9, 0, 0, Time.zone.formatted_offset)
        finish_time DateTime.new(2016, 4, 22, 22, 00, 0, Time.zone.formatted_offset)
      end
      second_day do
        date Time.utc(2016, 4, 23)
        start_time DateTime.new(2016, 4, 23, 11, 0, 0, Time.zone.formatted_offset)
        finish_time DateTime.new(2016, 4, 23, 21, 0, 0, Time.zone.formatted_offset)
      end
    end

    mailer do
      default_host "nastachku.ru"
      default_from "noreply@nastachku.ru"
    end

    mail do
      info 'info@nastachku.ru'
    end

    badges do
      time_to_print_badges DateTime.new(2016, 4, 21, 18, 0, 0)
    end

    token do
      auth_lifetime 3.days
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
      enable_auth true
      shop_url "nastachku.cs-cart.ru"
    end

    platidoma do
      host 'pg.platidoma.ru'
      transaction_view_host 'https://cabinet.paygate.platidoma.ru'
    end

    payanyway do
      host 'https://payanyway.ru'
      transaction_view_host 'https://moneta.ru'
      test_mode 0
    end

    yandexkassa do
      pay_url 'https://money.yandex.ru/eshop.xml'
    end

    timepad do
      maillist_add_items_url credentials_hash["production"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["production"]["timepad"]["organization_id"]
      maillist_id credentials_hash["production"]["timepad"]["maillist_id"]
      api_key credentials_hash["production"]["timepad"]["api_key"]
    end

    default_distributor 'nastachku.ru'

    phones do
      valeriy '+7(902)355-55-99'
    end
  end

  env :development, parent: :production do
    redis_host 'redis'

    move_to_top_count 2

    now_time -> {Time.zone.now + 3.days}

    analytics do
      host 'staging.nastachku.ru'
    end

    facebook do
      app_id credentials_hash["development"]["facebook"]["app_id"]
      app_secret credentials_hash["development"]["facebook"]["app_secret"]
    end

    cs_cart do
      enable_auth false
      secret_key credentials_hash["development"]["cs-cart"]["secret_key"]
      shop_url "10.10.10.10/shop"
    end

    platidoma do
      host 'pg-test.platidoma.ru'
    end

    payanyway do
      host 'https://demo.moneta.ru'
      test_mode 0
    end

    yandexkassa do
      pay_url 'https://demomoney.yandex.ru/eshop.xml'
    end

    timepad do
      maillist_add_items_url credentials_hash["development"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["development"]["timepad"]["organization_id"]
      maillist_id credentials_hash["development"]["timepad"]["maillist_id"]
      api_key credentials_hash["development"]["timepad"]["api_key"]
    end

  end

  env :test, parent: :production do
    redis_host 'redis'

    platidoma do
      host 'pg-test.platidoma.ru'
    end

    payanyway do
      host 'https://demo.moneta.ru'
      test_mode 0
    end
  end

  env :staging, parent: :production do
    redis_host 'localhost'

    now_time -> {Time.zone.now + 3.days}

    analytics do
      host 'staging.nastachku.ru'
    end

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
      shop_url "shop-staging.nastachku.ru"
    end

    platidoma do
      host 'pg-test.platidoma.ru'
      transaction_view_host 'https://cabinet.paygate-test.platidoma.ru'
    end

    payanyway do
      host 'https://demo.moneta.ru'
      transaction_view_host 'https://demo.moneta.ru'
      test_mode 0
    end

    yandexkassa do
      pay_url 'https://demomoney.yandex.ru/eshop.xml'
    end

    timepad do
      maillist_add_items_url credentials_hash["staging"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["staging"]["timepad"]["organization_id"]
      maillist_id credentials_hash["staging"]["timepad"]["maillist_id"]
      api_key credentials_hash["staging"]["timepad"]["api_key"]
    end
  end
end
