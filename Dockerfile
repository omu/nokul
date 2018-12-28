FROM ondokuz/ruby-stretch:0.10.0

RUN apt-get update \
    && apt-get -y --no-install-recommends install xfonts-75dpi=1:1.0.4+nmu1 xfonts-base=1:1.0.4+nmu1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && dpkg -i wkhtmlto* \
    && rm -f wkhtmlto*

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
