# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version')

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# core
gem 'bootsnap', '>= 1.1.0', require: false
gem 'pg'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'
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
  gem 'bundler-audit'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'rubocop'
  gem 'simplecov', require: false
end

group :test do
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'codacy-coverage', require: false
  gem 'selenium-webdriver'
  gem 'webmock'
end

group :development do
  gem 'bullet'
  gem 'fit-commit'
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'ruby-progressbar'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0' # call <%= console %> anywhere in the code.
end
