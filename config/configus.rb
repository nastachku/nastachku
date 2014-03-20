# encoding: utf-8

Configus.build Rails.env do
  #TODO расширить configus
  credentials_hash = YAML.load(File.read("config/credentials.yml"))

  env :production do

    rails do
      secret_token credentials_hash["production"]["rails"]["secret_token"]
    end

    pagination do
      admin_per_page 50
      audits_per_page 20
    end

    schedule do
      first_day do
        date Time.utc(2014, 4, 11)
        start_time DateTime.new(2014, 4, 11, 9, 0, 0)
        finish_time DateTime.new(2014, 4, 11, 21, 0, 0)
      end
      second_day do
        date Time.utc(2014, 4, 12)
        start_time DateTime.new(2014, 4, 12, 10, 0, 0)
        finish_time DateTime.new(2014, 4, 12, 18, 0, 0)
      end
    end

    mailer do
      default_host "nastachku.ru"
      default_from "noreply@nastachku.ru"
    end

    admin do
      email "admin@np.kaize.ru"
      password "123456"
      first_name "Админ"
      last_name "Админов"
      city 'Москва'
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

    platidoma do
      host credentials_hash["production"]["platidoma"]["host"]
      shop_id credentials_hash["production"]["platidoma"]["shop_id"]
      login credentials_hash["production"]["platidoma"]["login"]
      gate_password credentials_hash["production"]["platidoma"]["gate_password"]
      shirt_price 500
      afterparty_price 1500
      if Time.current.month == 2
        ticket_price 750
      elsif Time.current.month == 3
        ticket_price 1100
      elsif Time.current.month == 4
        ticket_price 1500
      end
    end

    cache do
      expires_in 5.minutes
    end

    timepad do
      maillist_add_items_url credentials_hash["production"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["production"]["timepad"]["organization_id"]
      maillist_id credentials_hash["production"]["timepad"]["maillist_id"]
      api_key credentials_hash["production"]["timepad"]["api_key"]
    end

  end

  env :development, parent: :production do

    rails do
      secret_token credentials_hash["development"]["rails"]["secret_token"]
    end

    admin do
      email "admin@np.kaize.ru"
      password "123456"
      first_name "Админ"
      last_name "Админов"
    end

    facebook do
      app_id credentials_hash["development"]["facebook"]["app_id"]
      app_secret credentials_hash["development"]["facebook"]["app_secret"]
    end

    platidoma do
      host credentials_hash["development"]["platidoma"]["host"]
      shop_id credentials_hash["development"]["platidoma"]["shop_id"]
      login credentials_hash["development"]["platidoma"]["login"]
      gate_password credentials_hash["development"]["platidoma"]["gate_password"]
      shirt_price 500
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
      url "https://pg-test.platidoma.ru/"
      shop_id 7
      login "test"
      gate_password "test"
      shirt_price 500
    end
  end

  env :staging, parent: :production do

    rails do
      secret_token credentials_hash["staging"]["rails"]["secret_token"]
    end

    admin do
      email "admin@np.kaize.ru"
      password "123456"
      first_name "Админ"
      last_name "Админов"
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

    platidoma do
      host credentials_hash["staging"]["platidoma"]["host"]
      shop_id credentials_hash["staging"]["platidoma"]["shop_id"]
      login credentials_hash["staging"]["platidoma"]["login"]
      gate_password credentials_hash["staging"]["platidoma"]["gate_password"]
      shirt_price 500
    end

    timepad do
      maillist_add_items_url credentials_hash["staging"]["timepad"]["maillist_add_items_url"]
      organization_id credentials_hash["staging"]["timepad"]["organization_id"]
      maillist_id credentials_hash["staging"]["timepad"]["maillist_id"]
      api_key credentials_hash["staging"]["timepad"]["api_key"]
    end

  end

end
