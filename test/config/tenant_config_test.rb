# frozen_string_literal: true

require 'test_helper'

class TenantConfigTest < ActiveSupport::TestCase
  test 'App must be booted with a default tenant' do
    assert_not_nil Tenant.name
  end

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

  test 'Tenant has a valid branding data' do
    config = YAML.load_file(Tenant.engine.config_file_for(:tenant))
    branding_data = config['production']['branding']
    assert branding_data['logo'].key?('file')
    assert branding_data['badge'].key?('file')
    assert branding_data['background'].key?('file')
  end
end
