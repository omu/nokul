# frozen_string_literal: true

require 'test_helper'

class UnitTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_types(:university)
  end

  # relations
  test 'unit_type can communicate with units' do
    assert @object.units
  end
end
