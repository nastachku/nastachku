Configus.build Rails.env do
  env :production do
    mailer do
      default_host "nastachku.ru"
      default_from "noreply@nastachku.ru"
    end

    admin do
      email ""
      password ""
      first_name = "admin"
      last_name = "admin"
    end

    token do
      lifetime 1.hour
    end
  end

  env :development, parent: :production do
    admin do
      email "admin@np.kaize.ru"
      password "123456"
    end
  end

  env :test, parent: :production do
  end

  env :staging, parent: :production do
    admin do
      email "admin@np.kaize.ru"
      password "123456"
      first_name = "admin"
      last_name = "admin"
    end

    basic_auth do
      username 'admin'
      password '123654'
    end
    
  end

end