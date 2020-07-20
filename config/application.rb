# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nokul
  class Application < Rails::Application
    # multi-tenancy
    Nokul::Tenant.load

    config.before_initialize do
      require 'nokul/sso'
      require 'nokul/name'
      require 'nokul/database_url'
      require 'nokul/version'
    end

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # time-zone. ActiveSupport::TimeZone.all for all possible values
    config.time_zone = 'Istanbul'

    # default language
    config.i18n.default_locale = :tr

    # support Turkish and English as locales
    I18n.available_locales = %i[tr en]

    # auto-load nested translation folders ie: locales/models/foo.yml
    I18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]

    # use app-wide e-mail template for devise
    config.to_prepare { Devise::Mailer.layout 'mailer' }

    # image-processor
    config.active_storage.variant_processor = :vips

    # schema dump sformat
    config.active_record.schema_format = :sql

    # use rack-attack as middleware
    config.middleware.use Rack::Attack

    # default mailer settings
    config.action_mailer.default_url_options = {
      host: Nokul::Tenant.configuration.host
    }
  end
end
