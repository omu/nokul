# frozen_string_literal: true

require 'test_helper'

class TenantConventionTest < ActiveSupport::TestCase
  test 'active tenant' do
    assert Tenant.active.is_a? String
    assert_not_empty Tenant.active
  end

  test 'tenant root' do
    assert Tenant.root.is_a? Pathname
    assert_not_empty Tenant.root
    assert Dir.exist? Tenant.root
  end

  test 'tenant path' do
    assert Tenant.path.is_a? String
    assert_not_empty Tenant.path
    assert Tenant.root.to_s, Tenant.path
  end

  test 'tenant config file' do
    assert Tenant.config_file.is_a? String
    assert_not_empty Tenant.config_file
    assert File.exist? Tenant.config_file
  end

  test 'tenant configuration' do
    assert Tenant.configuration.is_a? OpenStruct
    assert Tenant.configuration
  end

  test 'tenant common path' do
    assert Tenant::Path.common.is_a? Pathname
    assert_not_empty Tenant::Path.common
    assert Dir.exist? Tenant::Path.common
  end

  DIRECTORIES = %w[
    app
    config
    db
    test
  ].freeze

  test 'tenant sub directory paths' do
    DIRECTORIES.each do |dir|
      assert Tenant::Path.respond_to? dir
      assert Tenant::Path.respond_to? "common_#{dir}"

      paths = [
        Tenant::Path.send(dir),
        Tenant::Path.send("common_#{dir}")
      ]

      paths.all? do |path|
        assert path.is_a? Pathname
        assert_not_empty path
      end
    end
  end
end
