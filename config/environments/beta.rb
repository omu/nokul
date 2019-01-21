# frozen_string_literal: true

# Based on production defaults
require Rails.root.join('config', 'environments', 'production.rb')

Rails.application.configure do
  config.force_ssl = false if ENV['NOKUL_DISABLE_SSL']
end
