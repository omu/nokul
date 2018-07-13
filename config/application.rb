# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nokul
  class Application < Rails::Application
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

    # organize models in sub-folders
    config.autoload_paths += Dir[
      Rails.root.join('app', 'models', '**')
    ]

    reloader.to_prepare do
      Dir[
        Rails.root.join('app', 'services', '**', '*.rb')
      ].each { |file| require_dependency file }
    end

    # use app-wide e-mail template for devise
    config.to_prepare { Devise::Mailer.layout 'mailer' }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
