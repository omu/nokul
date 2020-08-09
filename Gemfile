# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read(File.expand_path('.ruby-version', __dir__))

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# core
gem 'bootsnap', require: false
gem 'puma'
gem 'rails', github: 'rails/rails'
gem 'redis', '~> 4.2'
gem 'sidekiq'

# database
gem 'pg'
gem 'pghero', '>= 2.7.0'
gem 'pg_search', '>= 2.3.2'
gem 'rein', '>= 5.1.0'

# active-record
gem 'ancestry', '>= 3.0.7'

# active-storage
gem 'aws-sdk-s3', require: false
gem 'image_processing', '~> 1.11.0'
gem 'ruby-vips', '~> 2.0.17'

# authentication
gem 'authy'
gem 'devise', '>= 4.7.1'
gem 'omniauth_openid_connect', '>= 0.3.3'

# authorization
gem 'pundit', '>= 2.1.0'

# ldap
gem 'net-ldap'

# assets: core asset dependencies
# TODO: The following line should be removed when sassc-rails has the latest version of sassc.
gem 'sassc', '~> 2.4.0'
gem 'sassc-rails', '>= 2.1.2'

gem 'coffee-rails'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', github: 'rails/webpacker'

# view helpers: tools for forms, views, etc.
gem 'chartkick', '>= 3.4.0'
gem 'cocoon'
gem 'font-awesome-rails', '>= 4.7.0.5'
gem 'groupdate', '>= 5.0.0'
gem 'pagy'
gem 'simple_form', '>= 5.0.2'
gem 'wicked_pdf', '>= 2.0.2'

# api
gem 'jbuilder', '~> 2.10', '>= 2.10.0'

# security
gem 'bcrypt', '~> 3.1.15'
gem 'pwned'
gem 'rack-attack'
gem 'recaptcha'

# validators
gem 'telephone_number'
gem 'valid_email2', '>= 3.2.2'

# error tracking
gem 'rollbar'
gem 'slack-notifier'

# permalinks
gem 'friendly_id', '~> 5.3.0'

# sms
gem 'twilio-ruby'

# log
gem 'lograge', '>= 0.11.2'

# cron
gem 'sidekiq-cron'

group :development, :test do
  gem 'brakeman', require: false
  gem 'bullet', github: 'flyerhzm/bullet'
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '>= 2.7.5'
  gem 'erb_lint', require: false
  gem 'lol_dba', '>= 2.2.0'
  gem 'rubocop'
  gem 'rubocop-minitest'
  gem 'rubocop-performance'
  gem 'rubocop-rails', '>= 2.5.2'
  gem 'simplecov', require: false
end

group :test do
  gem 'capybara'
  gem 'minitest-focus'
  gem 'simplecov-cobertura'
  gem 'webdrivers', '~> 4.4'
  gem 'webmock'
end

group :development do
  gem 'fit-commit'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'pry-rails'
  gem 'rack-mini-profiler'
  gem 'ruby-progressbar'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', github: 'rails/web-console'
end

# core plugins
gem 'nokul-support', path: 'plugins/support'
gem 'nokul-tenant',  path: 'plugins/tenant/common'

# tenants (won't be listed at Rails.groups)
Dir['plugins/tenant/**/*.gemspec'].each do |gemspec|
  next if (name = File.basename(gemspec, '.gemspec')) == 'nokul-tenant'

  gem name, path: File.dirname(gemspec), require: false
end

gem 'active_flag', '>= 1.5.0'
