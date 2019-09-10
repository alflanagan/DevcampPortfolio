FROM ruby:2.6.3

ARG appuser
ARG apphome
ARG railsenv

ENV LANG C.UTF-8
ENV RAILS_ENV ${railsenv}

RUN gem install bundler

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# throw errors if Gemfile has been modified since Gemfile.lock
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn \
  && bundle config --global frozen 1

RUN adduser --gecos '' --disabled-password $appuser

USER $appuser

WORKDIR /home/$appuser

RUN mkdir -p $apphome/vendor

COPY --chown=$appuser:$appuser ./Gemfile $apphome/Gemfile

COPY --chown=$appuser:$appuser ./Gemfile.lock $apphome/Gemfile.lock

WORKDIR $apphome

RUN bundle install --path=vendor/bundle

SHELL ["bash", "--login", "-c"]

RUN echo 'export PATH=${HOME}/app/bin:${PATH}' >> ${HOME}/.bash_profile

COPY --chown=$appuser:$appuser . $apphome

RUN yarn install --check-files

RUN bundle exec rails webpacker:install

RUN bundle exec rails webpacker:compile
