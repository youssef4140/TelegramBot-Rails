FROM ruby:3.0.2

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    nodejs \
    sqlite3 \
    libsqlite3-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

RUN bundle exec rake db:migrate

CMD ["rails", "server", "-b", "0.0.0.0"]