# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read(File.expand_path('.ruby-version', __dir__))

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# core
gem 'bootsnap', require: false
gem 'puma'
gem 'rails', '~> 6.0', '>= 6.0.2.2'
gem 'redis', '~> 4.1'
gem 'sidekiq', '>= 6.0.7'

# database
gem 'pg'
gem 'pg_search'
gem 'pghero'
gem 'rein'

# active-record
gem 'ancestry'

# active-storage
gem 'aws-sdk-s3', require: false
gem 'image_processing', '~> 1.10.3'
gem 'ruby-vips', '~> 2.0.17'

# authentication
gem 'authy'
gem 'devise', '>= 4.7.1'
gem 'omniauth_openid_connect', '>= 0.3.3'

# authorization
gem 'pundit'

# ldap
gem 'net-ldap'

# assets: core asset dependencies
# TODO: The following line should be removed when sassc-rails has the latest version of sassc.
gem 'sassc', '~> 2.3.0'
gem 'sassc-rails', '>= 2.1.2'

gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '>= 5.1.1'

# view helpers: tools for forms, views, etc.
gem 'chartkick'
gem 'cocoon'
gem 'font-awesome-rails', '>= 4.7.0.5'
gem 'groupdate'
gem 'pagy'
gem 'simple_form', '>= 5.0.2'
gem 'wicked_pdf'

# api
gem 'jbuilder', '~> 2.10'

# security
gem 'bcrypt', '~> 3.1.7'
gem 'pwned'
gem 'rack-attack', '>= 6.3.0'

# validators
gem 'telephone_number'
gem 'valid_email2'

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
gem 'sidekiq-cron', '>= 1.2.0'

group :development, :test do
  gem 'brakeman', require: false
  gem 'bullet'
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
  gem 'capybara', '>= 3.32.1'
  gem 'codacy-coverage', require: false
  gem 'minitest-focus'
  gem 'webdrivers', '~> 4.3'
  gem 'webmock'
end

group :development do
  gem 'fit-commit'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.3'
  gem 'pry-rails'
  gem 'rack-mini-profiler', '>= 2.0.1'
  gem 'ruby-progressbar'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 4.0.2'
end

# core plugins
gem 'nokul-support', path: 'plugins/support'
gem 'nokul-tenant',  path: 'plugins/tenant/common'

# tenants (won't be listed at Rails.groups)
Dir['plugins/tenant/**/*.gemspec'].each do |gemspec|
  next if (name = File.basename(gemspec, '.gemspec')) == 'nokul-tenant'

  gem name, path: File.dirname(gemspec), require: false
end

gem 'active_flag'
