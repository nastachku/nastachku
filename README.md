[![Build Status](https://travis-ci.org/nastachku/nastachku.svg?branch=develop)](https://travis-ci.org/nastachku/nastachku)

## Installation and running way
```sh
  git clone https://github.com/nastachku/nastachku.git
  cd nastachku

  bundle install
  sudo apt-get install redis-server

  bundle exec rake db:create db:migrate db:seed
  bundle exec unicorn
```

  Теперь в браузере можно будет открыть сайт, по умолчанию он находится
по ссылке http://localhost:8080/
