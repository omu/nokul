FROM ondokuz/ruby-stretch:0.10.0

ENV PATH=/app/bin:$PATH

RUN apt-get update \
    && apt-get -y --no-install-recommends install xfonts-75dpi=1:1.0.4+nmu1 xfonts-base=1:1.0.4+nmu1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && dpkg -i wkhtmlto* \
    && rm -f wkhtmlto*

ARG NOKUL_TENANT=omu
ENV NOKUL_TENANT=$NOKUL_TENANT

ARG RAILS_ENV=beta
ENV RAILS_ENV=$RAILS_ENV

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY

ENV RAILS_SERVE_STATIC_FILES=enabled
ENV RAILS_LOG_TO_STDOUT=enabled

WORKDIR /app

COPY .ruby-version ./
COPY Gemfile Gemfile.lock ./
COPY package.json yarn.lock ./

COPY plugins/support/lib/nokul/support/version.rb      ./plugins/support/lib/nokul/support/version.rb
COPY plugins/support/nokul-support.gemspec             ./plugins/support/nokul-support.gemspec

COPY plugins/tenant/common/lib/nokul/tenant/version.rb ./plugins/tenant/common/lib/nokul/tenant/version.rb
COPY plugins/tenant/common/nokul-tenant.gemspec        ./plugins/tenant/common/nokul-tenant.gemspec

COPY plugins/tenant/$NOKUL_TENANT/lib/nokul/tenant/$NOKUL_TENANT/version.rb ./plugins/tenant/$NOKUL_TENANT/lib/nokul/tenant/$NOKUL_TENANT/version.rb
COPY plugins/tenant/$NOKUL_TENANT/nokul-tenant-$NOKUL_TENANT.gemspec        ./plugins/tenant/$NOKUL_TENANT/nokul-tenant-$NOKUL_TENANT.gemspec

RUN bundle config --global silence_root_warning true
RUN bundle install --without development:test:plugins -j4 --deployment
RUN yarn install

COPY . ./

RUN bundle install --with plugins -j4 --deployment

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD bundle exec puma -C config/puma.rb
