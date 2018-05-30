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

# authentication
gem 'devise'

# assets: core asset dependencies
gem 'coffee-rails', '~> 4.2'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# view helpers: tools for forms, views, etc.
gem 'cocoon'
gem 'font-awesome-rails'
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

group :development, :test do
  gem 'brakeman', require: false
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'chromedriver-helper'
  gem 'codacy-coverage', require: false
  gem 'pry-rails'
  gem 'rails_best_practices'
  gem 'reek'
  gem 'rubocop'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
end

group :development do
  gem 'annotate'
  gem 'bundler-audit'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubycritic'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # call <%= console %> anywhere in the code.
end
