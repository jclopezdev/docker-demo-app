FROM ruby:2.3.3

RUN apt-get update && apt-get install -qq -y build-essential libpq-dev postgresql-client-9.4 apt-transport-https

# Using Debian, as root
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get install -y nodejs

ENV APP_HOME /usr/src/app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
ADD package.json* $APP_HOME/
RUN bundle install --jobs 20 --retry 5
RUN npm install
