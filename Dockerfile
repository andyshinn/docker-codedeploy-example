FROM ruby:2.2.0-slim

RUN apt-get update -q && apt-get install -qy build-essential

WORKDIR /app

COPY ./Gemfile /app/
COPY ./Gemfile.lock /app/

RUN bundle install \
  --binstubs \
  --retry 3 \
  --jobs 4 \
  --deployment
  
COPY . /app

ENV EXECJS_RUNTIME RubyRacer

CMD bin/middleman build && tar -zcvf build.tar.gz build
