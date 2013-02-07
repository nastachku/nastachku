Configus.build Rails.env do
  env :production do
    mailer do
      default_host "nastachku.ru"
      default_from "noreply@nastachku.ru"
    end

    admin do
      email ""
      password ""
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
    end
  end

end