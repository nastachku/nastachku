[![Build Status](https://travis-ci.org/ulmic/nastachku.png?branch=develop)](https://travis-ci.org/ulmic/nastachku)

## Installation and running way
```sh
  git clone https://github.com/kaize/nastachku.git
  cd nastachku
  bundle install
  bundle exec rake db:create db:migrate db:seed
  bundle exec unicorn_rails
```

  Теперь в браузере можно будет открыть сайт, по умолчанию он находится
по ссылке http://localhost:8080/
