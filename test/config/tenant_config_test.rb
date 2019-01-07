# frozen_string_literal: true

require 'test_helper'

class TenantConfigTest < ActiveSupport::TestCase
  test 'Configuration can read tenant settings' do
    assert_not_nil Tenant.configuration.abbreviation
    assert_not_nil Tenant.configuration.host
  end

  test 'Tenant main configuration includes keys for various environments' do
    config = YAML.load_file(Tenant.engine.config_file_for(:tenant))
    assert config.key?('production')
    assert config.key?('beta')
    assert config.key?('test')
    assert config.key?('development')
  end
end
