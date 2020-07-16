# frozen_string_literal: true

require 'test_helper'

# tests database config to prevent the app from unexpected changes!

class DatabaseConfigTest < ActiveSupport::TestCase
  test 'All environments must use PostgreSQL as database' do
    %w[development test production].each do |environment|
      config = ActiveRecord::Base.configurations.configs_for(env_name: environment, name: 'primary').configuration_hash
      assert_equal config[:adapter], 'postgresql'
    end
  end

  test 'All environments must use unicode coding schema for databases' do
    %w[development test production].each do |environment|
      config = ActiveRecord::Base.configurations.configs_for(env_name: environment, name: 'primary').configuration_hash
      assert_equal config[:encoding], 'unicode'
    end
  end

  test "Development and test environment database users must be #{Nokul::Name.application}" do
    %w[development test].each do |environment|
      config = ActiveRecord::Base.configurations.configs_for(env_name: environment, name: 'primary').configuration_hash
      assert_equal config[:username], Nokul::Name.application
    end
  end

  test 'development environment database name must be nokul_development' do
    config = ActiveRecord::Base.configurations.configs_for(env_name: 'development', name: 'primary').configuration_hash
    assert_equal config[:database], 'nokul_development'
  end

  test 'test environment database name must start with nokul_test' do
    config = ActiveRecord::Base.configurations.configs_for(env_name: 'test', name: 'primary').configuration_hash
    assert config[:database].starts_with?('nokul_test')
  end
end
