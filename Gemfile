# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.1'

# core
gem 'bootsnap', '>= 1.1.0', require: false # Reduces boot times through caching; required in config/boot.rb
gem 'pg'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.0'
gem 'redis'
gem 'sidekiq'

# active-record
gem 'ancestry'

# active-storage
gem 'aws-sdk-s3', require: false
gem 'image_processing', '~> 1.0'

# authentication
gem 'devise'

# assets: core asset dependencies
gem 'coffee-rails', '~> 4.2'
gem 'sassc-rails'
gem 'uglifier', '>= 1.3.0'

# view helpers: tools for forms, views, etc.
gem 'chartkick'
gem 'cocoon'
gem 'font-awesome-rails'
gem 'groupdate' # for chartkick
gem 'pagy'
gem 'simple_form'

# api
gem 'jbuilder', '~> 2.5'
gem 'savon', '~> 2.12.0'

# security
gem 'bcrypt', '~> 3.1.7'

# validators
gem 'email_address'

# search
gem 'pg_search'

# error tracking
gem 'rollbar'

# permalinks
gem 'friendly_id', '~> 5.2.0'

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'chromedriver-helper'
  gem 'codacy-coverage', require: false
  gem 'dotenv-rails'
  gem 'pry-rails'
  gem 'reek'
  gem 'rubocop'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end

group :development do
  gem 'bullet'
  gem 'bundler-audit'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # call <%= console %> anywhere in the code.
end
