# frozen_string_literal: true

require 'test_helper'

# tests config/application.rb configuration to prevent the app from unexpected config changes!

class ApplicationConfigTest < ActiveSupport::TestCase
  setup do
    @config = Rails.application.config
  end

  test 'Configuration defaults should match with Rails version' do
    assert_equal @config.loaded_config_version, Rails.version.to_f
  end

  test 'Compare Gemfile Rails version with configured Rails version' do
    assert_equal Gem.loaded_specs['rails'].version.to_s.first(3), Gem::Version.new(@config.loaded_config_version).to_s
  end

  test 'Time zone should match with Istanbul' do
    assert_equal('Istanbul', @config.time_zone)
  end

  test 'Default locale should be Turkish' do
    assert_equal(:tr, @config.i18n.default_locale)
  end

  test 'Turkish and English must be in available locales' do
    assert_includes(I18n.available_locales, :tr)
    assert_includes(I18n.available_locales, :en)
  end

  test 'image_processor is set to :vips' do
    assert_equal(:vips, Rails.application.config.active_storage.variant_processor)
  end

  test 'schema format is set to :sql' do
    assert_equal(:sql, Rails.application.config.active_record.schema_format)
  end

  test 'rack::attack is up and running as middleware' do
    assert_includes(Rails.application.config.middleware.middlewares, Rack::Attack)
  end
end
