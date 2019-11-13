# Create ruby environment and dependencies. Postgres
FROM ruby:2.6.3

ADD https://dl.yarnpkg.com/debian/pubkey.gpg /tmp/yarn-pubkey.gpg
RUN apt-key add /tmp/yarn-pubkey.gpg && rm /tmp/yarn-pubkey.gpg
RUN echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential libpq-dev curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get update && apt-get install -qq -y --no-install-recommends nodejs yarn


# Create the working directory
RUN mkdir /radius-on-rails
WORKDIR /radius-on-rails
COPY Gemfile /radius-on-rails/Gemfile
COPY Gemfile.lock /radius-on-rails/Gemfile.lock
RUN bundle install
COPY . /radius-on-rails

# Create an entrypoint to be started everytime. Needed because of a rails issue according to Docker
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]