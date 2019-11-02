# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read(File.expand_path('.ruby-version', __dir__))

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# core
gem 'bootsnap', require: false
gem 'puma'
gem 'rails', '~> 6.0'
gem 'redis', '~> 4.0'
gem 'sidekiq'

# database
gem 'pg'
gem 'pg_search'
gem 'pghero'
gem 'rein'

# active-record
gem 'ancestry'

# active-storage
gem 'aws-sdk-s3', require: false
gem 'image_processing', '~> 1.2'
gem 'ruby-vips', '~> 2.0.16'

# authentication
gem 'authy'
gem 'devise'

# authorization
gem 'pundit'

# ldap
gem 'net-ldap'

# assets: core asset dependencies
# TODO: The following line should be removed when sassc-rails has the latest version of sassc.
gem 'sassc', '~> 2.2.1'
gem 'sassc-rails'

gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

# view helpers: tools for forms, views, etc.
gem 'chartkick'
gem 'cocoon'
gem 'font-awesome-rails'
gem 'groupdate'
gem 'pagy'
gem 'simple_form'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# api
gem 'jbuilder', '~> 2.9'

# security
gem 'bcrypt', '~> 3.1.7'
gem 'pwned'
gem 'rack-attack'

# validators
gem 'email_address'
gem 'telephone_number'

# error tracking
gem 'rollbar'
gem 'slack-notifier'

# permalinks
gem 'friendly_id', '~> 5.3.0'

# sms
gem 'nexmo'
gem 'smstools'
gem 'twilio-ruby'

# log
gem 'lograge'

group :development, :test do
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'erb_lint', require: false
  gem 'lol_dba'
  gem 'rubocop'
  gem 'rubocop-minitest'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'simplecov', require: false
end

group :test do
  gem 'capybara'
  gem 'codacy-coverage', require: false
  gem 'minitest-focus'
  gem 'webdrivers', '~> 4.1'
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
  gem 'web-console'
end

# core plugins
gem 'nokul-support', path: 'plugins/support'
gem 'nokul-tenant',  path: 'plugins/tenant/common'

# tenants (won't be listed at Rails.groups)
Dir['plugins/tenant/**/*.gemspec'].each do |gemspec|
  next if (name = File.basename(gemspec, '.gemspec')) == 'nokul-tenant'

  gem name, path: File.dirname(gemspec), require: false
end
