[![Build Status](https://travis-ci.org/ulmic/nastachku.png?branch=develop)](https://travis-ci.org/ulmic/nastachku)
[![Coverage Status](https://coveralls.io/repos/ulmic/nastachku/badge.png?branch=master)](https://coveralls.io/r/ulmic/nastachku?branch=2013-master)
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
