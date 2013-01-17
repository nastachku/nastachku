[![Build Status](https://travis-ci.org/kaize/nastachku.png)](undefined)

## Installation and running way
```sh
  git clone https://github.com/kaize/nastachku.git
  cd itc73
  bundle install
  bundle exec rake db:create db:migrate db:seed
  bundle exec unicorn_rails
```

  Теперь в браузере можно будет открыть сайт, по умолчанию он находится
по ссылке http://localhost:8080/