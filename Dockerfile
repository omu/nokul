FROM ondokuz/ruby-stretch:1.15.1

ENV PATH=/app/bin:$PATH

ARG NOKUL_TENANT=omu
ENV NOKUL_TENANT=$NOKUL_TENANT

ARG RAILS_ENV=beta
ENV RAILS_ENV=$RAILS_ENV

ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY=$RAILS_MASTER_KEY

ENV RAILS_SERVE_STATIC_FILES=enabled
ENV RAILS_LOG_TO_STDOUT=enabled

ENV NODE_ENV=production
ENV NODE_ENV=$NODE_ENV

RUN case $RAILS_ENV in \
    test) scripts runtime/chrome chrome_install_upstream=true && \
          apt-get clean && rm -rf /var/lib/apt/lists/* ;; \
    esac

WORKDIR /app

RUN bundle config --global silence_root_warning true

COPY . ./

EXPOSE 3000

CMD bundle exec puma -C config/puma.rb
