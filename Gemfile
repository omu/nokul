# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version')

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# core
gem 'bootsnap', '>= 1.1.0', require: false
gem 'puma', '~> 3.11'
gem 'rails', github: 'rails/rails'
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

# authentication
gem 'devise'

# assets: core asset dependencies
# TODO: Edge versions require coffee-rails https://github.com/rails/rails/issues/28965
gem 'coffee-rails', '~> 4.2'
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', github: 'rails/webpacker'

# view helpers: tools for forms, views, etc.
gem 'chartkick'
gem 'cocoon'
gem 'font-awesome-rails'
gem 'groupdate' # for chartkick
gem 'pagy'
gem 'simple_form'
gem 'wicked_pdf'

# api
gem 'jbuilder', '~> 2.5'

# security
gem 'bcrypt', '~> 3.1.7'
gem 'rack-attack'

# validators
gem 'email_address'
gem 'telephone_number'

# error tracking
gem 'rollbar', github: 'rollbar/rollbar-gem'

# permalinks
gem 'friendly_id', '~> 5.2.0'

group :development, :test do
  gem 'brakeman', require: false
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'lol_dba'
  gem 'rubocop'
  gem 'simplecov', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'codacy-coverage', require: false
  gem 'selenium-webdriver'
  gem 'webmock'
end

group :development do
  # TODO: Will re-enable after upgrading bullet.
  # gem 'bullet'
  gem 'fit-commit'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  # TODO: Will re-enable after upgrading rack-mini-profiler
  # gem 'rack-mini-profiler'
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
