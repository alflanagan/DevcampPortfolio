FROM ruby:2.6.3

ARG appuser
ARG apphome

ENV LANG C.UTF-8

RUN gem install bundler

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# throw errors if Gemfile has been modified since Gemfile.lock
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn \
  && bundle config --global frozen 1

RUN useradd -m -c"devcampportfolio application user" $appuser

WORKDIR /home/$appuser

USER $appuser:$appuser

RUN mkdir -p $apphome/vendor

COPY ./Gemfile $apphome/Gemfile

COPY ./Gemfile.lock $apphome/Gemfile.lock

WORKDIR $apphome

RUN bundle install --path=vendor/bundle

RUN yarn install --check-files

SHELL ["bash", "--login", "-c"]

RUN echo 'export PATH=${HOME}/app/bin:${PATH}' >> ${HOME}/.bash_profile

COPY --chown=$appuser:$appuser . $apphome

RUN bundle exec rake yarn:install

RUN bundle exec rake webpacker:install

RUN bundle exec rails webpacker:compile
