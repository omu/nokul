# frozen_string_literal: true

require 'test_helper'

# tests database config to prevent the app from unexpected changes!

class DatabaseConfigTest < ActiveSupport::TestCase
  test 'All environments must use PostgreSQL as database' do
    %w[development test production beta].all? do |environment|
      assert_equal ActiveRecord::Base.configurations[environment]['adapter'], 'postgresql'
    end
  end

  test 'All environments must use unicode coding schema for databases' do
    %w[development test production beta].all? do |environment|
      assert_equal ActiveRecord::Base.configurations[environment]['encoding'], 'unicode'
    end
  end

  name = Rails.application.class.parent.to_s.underscore

  test "Development and test environment database users must be #{name}" do
    %w[development test].all? do |environment|
      assert_equal ActiveRecord::Base.configurations[environment]['username'], "#{name}"
    end
  end

  %w[development test].each do |environment|
    test "#{environment.capitalize} environment database name must be #{name}_#{environment}" do
      assert_equal ActiveRecord::Base.configurations[environment]['database'], "#{name}_#{environment}"
    end
  end
end
