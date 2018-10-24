# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nokul
  class Application < Rails::Application
    # support libraries are used for tenant configuration and Rakefile,
    # therefore they have to required in the first place.
    Dir[
      Rails.root.join('lib', 'support', '**', '*.rb')
    ].each { |file| require file }

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # time-zone. ActiveSupport::TimeZone.all for all possible values
    config.time_zone = 'Istanbul'

    # we will set default locale to Turkish in the future
    config.i18n.default_locale = :tr

    # support Turkish and English as locales
    I18n.available_locales = %i[tr en]

    # auto-load nested translation folders ie: locales/models/foo.yml
    I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]

    # use app-wide e-mail template for devise
    config.to_prepare { Devise::Mailer.layout 'mailer' }

    # image-processor
    config.active_storage.variant_processor = :vips

    # tenant configuration
    config.active_tenant = Tenant.active
    config.tenant = Tenant.configuration
  end
end
