# frozen_string_literal: true

require 'test_helper'

# tests config/database.yml to prevent the app from unexpected config changes!

class DatabaseConfigTest < ActiveSupport::TestCase
  test 'Rails must use PostgreSQL as database' do
    assert_equal Rails.configuration.database_configuration['default']['adapter'], 'postgresql'
  end

  test 'Rails must use unicode coding schema for databases' do
    assert_equal Rails.configuration.database_configuration['default']['encoding'], 'unicode'
  end
end
