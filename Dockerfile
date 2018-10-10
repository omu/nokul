FROM ondokuz/ruby-stretch:0.10.0

ARG RAILS_ENV
ENV RAILS_ENV=$RAILS_ENV

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY

ENV RAILS_SERVE_STATIC_FILES=enabled
ENV RAILS_LOG_TO_STDOUT=enabled

WORKDIR /app

COPY .ruby-version ./
COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./

RUN bundle install --without development:test -j4 --deployment
RUN yarn install

COPY . ./

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD bundle exec puma -C config/puma.rb
