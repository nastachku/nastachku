Configus.build Rails.env do
  env :production do
    mailer do
      default_host "nastachku.ru"
      default_from "noreply@nastachku.ru"
    end
  end

  env :development, parent: :production do
  end

  env :test, parent: :production do
  end

  env :staging, parent: :production do
  end

end