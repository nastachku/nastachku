# encoding: utf-8

Configus.build Rails.env do
  env :production do

    pagination do
      audits_per_page 20
    end

    schedule do
      first_day Time.utc(2013, 4, 12)
      second_day Time.utc(2013, 4, 13)
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
      lifetime 1.hour
    end

    facebook do
      app_id '223587801118877'
      app_secret 'd196986f373c3fe86f79d881e270ae97'
    end

    twitter do
       key 'xH0ui4CoEcH39X5ucFyk0w'
       secret 'qqJwi8Nc3NQMHcm6IEbi4dYA8Z6eKpv8uSqm9VpMCEA'
    end

  end

  env :development, parent: :production do
    admin do
      email "admin@np.kaize.ru"
      password "123456"
      first_name "Админ"
      last_name "Админов"
    end

    facebook do
      app_id '223587801118877'
      app_secret 'd196986f373c3fe86f79d881e270ae97'
    end

    platidoma do
      url 'https://pg-test.platidoma.ru/payment.php'
      shop_id 7
      login "nastachku"
      gate_password "Emvexc234s"
      afterparty_price 1500
      shirt_price 500
    end

  end

  env :test, parent: :production do
    platidoma do
      url "https://pg-test.platidoma.ru/"
      shop_id 7
      login "test"
      gate_password "test"
      afterparty_price 1500
      shirt_price 500
    end
  end

  env :staging, parent: :production do
    admin do
      email "admin@np.kaize.ru"
      password "123456"
      first_name "Админ"
      last_name "Админов"
    end

    basic_auth do
      username 'admin'
      password '123654'
    end

    facebook do
      app_id '136776063163691'
      app_secret 'a17bec84850e3acd9e0b05bf0cafa878'
    end

    platidoma do
      url 'https://pg-test.platidoma.ru/payment.php'
      shop_id 7
      login "nastachku"
      gate_password "Emvexc234s"
      afterparty_price 1500
      shirt_price 500
    end
    
  end

end
