FROM ruby:2.6.4-alpine

ENV LANG C.UTF-8

WORKDIR /root

ADD Gemfile* ./

RUN set -x && \
  apk update && \
  apk add --no-cache build-base libxml2-dev libxslt-dev mysql-client mysql-dev tzdata bash && \
  gem install bundler -v 2.0.2 && \
  bundle install -j2

CMD ["bundle", "--version"]
