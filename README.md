[![Build Status](https://travis-ci.org/rocket-11/nastachku.svg?branch=develop)](https://travis-ci.org/rocket-11/nastachku)

## Installation and running way
```sh
  git clone https://github.com/rocket-11/nastachku.git
  cd nastachku
  bundle install
  bundle exec rake db:create db:migrate db:seed
  bundle exec unicorn_rails
  sudo apt-get install redis-server
```

  Теперь в браузере можно будет открыть сайт, по умолчанию он находится
по ссылке http://localhost:8080/
