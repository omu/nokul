# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nokul
  class Application < Rails::Application
    Nokul::Tenant.load

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # TODO: Disable zeitwerk until they publish something stable.
    # See: https://github.com/rails/rails/issues/35259 and https://github.com/rails/rails/issues/35278
    config.autoloader = :classic

    # time-zone. ActiveSupport::TimeZone.all for all possible values
    config.time_zone = 'Istanbul'

    # default language
    config.i18n.default_locale = :tr

    # support Turkish and English as locales
    I18n.available_locales = %i[tr en]

    # auto-load nested translation folders ie: locales/models/foo.yml
    I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]

    # use app-wide e-mail template for devise
    config.to_prepare { Devise::Mailer.layout 'mailer' }

    # image-processor
    config.active_storage.variant_processor = :vips

    # schema dump sformat
    config.active_record.schema_format = :sql

    # use rack-attack as middleware
    config.middleware.use Rack::Attack

    def appname
      @appname ||= if File.exist?(manifest = Rails.root.join('app.json'))
                     JSON.parse(File.read(manifest)).fetch 'name'
                   else
                     self.class.module_parent.to_s.underscore
                   end
    end

    def database_url_for(env)
      host = ENV.fetch('DB_HOST', 'localhost')

      "postgresql://#{appname}:#{appname}@#{host}/#{appname}_#{env}"
    end
  end
end
