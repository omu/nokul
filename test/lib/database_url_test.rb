# frozen_string_literal: true

require 'test_helper'

class DatabaseUrlTest < ActiveSupport::TestCase
  test 'Database URL is available for production' do
    assert_not_nil Nokul::DatabaseUrl.production
  end
end
