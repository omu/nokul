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

  test 'Tenant settings must be configured in tenants/*.yml' do
    files_count = Dir.glob(Rails.root.join('config', 'tenants', '*.yml')).count
    assert_operator files_count, :>, 0
  end

  test 'Configuration can read tenant settings' do
    assert_not_nil @config.tenant.abbreviation
    assert_not_nil @config.tenant.host
  end
end
