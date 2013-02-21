# encoding: utf-8

Configus.build Rails.env do
  env :production do
    mailer do
      default_host "nastachku.ru"
      default_from "noreply@nastachku.ru"
    end

    admin do
      email "admin@np.kaize.ru"
      password "123456"
      first_name "Админ"
      last_name "Админов"
    end

    token do
      lifetime 1.hour
    end
  end

  env :development, parent: :production do
    admin do
      email "admin@np.kaize.ru"
      password "123456"
      first_name "Админ"
      last_name "Админов"
    end
  end

  env :test, parent: :production do
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
    
  end

end