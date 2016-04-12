FROM ruby:2.2.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev curl postgresql-client imagemagick
RUN mkdir /myapp
WORKDIR /myapp
ADD . /myapp
RUN bundle install --path=vendor/bundle
