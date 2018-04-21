# frozen_string_literal: true

require 'test_helper'

# tests config/application.rb configuration to prevent the app from unexpected config changes!

class ApplicationConfigTest < ActiveSupport::TestCase
  test 'Configuration defaults for should match with Rails version' do
    assert_equal Rails.application.config.loaded_config_version, Rails.version.to_f
  end

  test 'Compare Gemfile Rails version with configured Rails version' do
    assert_equal Gem.loaded_specs['rails'].version.to_s.to_f, Rails.application.config.loaded_config_version
  end

  test 'Time zone should match with Istanbul' do
    assert_equal Rails.application.config.time_zone, 'Istanbul'
  end
end
