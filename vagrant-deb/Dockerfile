FROM ruby:2.6.3

ENV LANG C.UTF-8

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD "pwd"
# CMD "ls -A"
# CMD "./bin/rails db:setup"
# CMD ["./your-daemon-or-script.rb"]
