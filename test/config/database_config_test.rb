# frozen_string_literal: true

require 'test_helper'

# tests database config to prevent the app from unexpected changes!

class DatabaseConfigTest < ActiveSupport::TestCase
  test 'All environments must use PostgreSQL as database' do
    %w[development test].each do |environment|
      assert_equal ActiveRecord::Base.configurations[environment]['adapter'], 'postgresql'
    end
  end

  test 'All environments must use unicode coding schema for databases' do
    %w[development test].each do |environment|
      assert_equal ActiveRecord::Base.configurations[environment]['encoding'], 'unicode'
    end
  end

  name = Rails.application.class.module_parent.to_s.underscore

  test "Development and test environment database users must be #{name}" do
    %w[development test].each do |environment|
      assert_equal ActiveRecord::Base.configurations[environment]['username'], name
    end
  end

  test 'development environment database name must be nokul_development' do
    assert_equal ActiveRecord::Base.configurations['development']['database'], 'nokul_development'
  end

  test 'test environment database name must start with nokul_test' do
    assert ActiveRecord::Base.configurations['test']['database'].starts_with?('nokul_test')
  end
end
