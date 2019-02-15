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
    assert_equal @config.time_zone, 'Istanbul'
  end

  test 'Default locale should be Turkish' do
    assert_equal @config.i18n.default_locale, :tr
  end

  test 'Turkish and English must be in available locales' do
    assert I18n.available_locales.include?(:tr)
    assert I18n.available_locales.include?(:en)
  end

  test 'appname can be read either from app.json or application class' do
    assert_not_nil Rails.application.appname
  end

  test 'rack::attack is up and running as middleware' do
    assert Rails.application.config.middleware.middlewares.include?(Rack::Attack)
  end

  test 'autoloader is set to :classic until Rails 6 stable' do
    assert_equal Rails.application.config.autoloader, :classic
  end
end
