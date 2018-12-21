# frozen_string_literal: true

require 'test_helper'

class UnitStatusTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_statuses(:passive)
  end

  # relations
  test 'unit_status can communicate with units' do
    assert @object.units
  end

  # scopes
  test 'return a active unit status' do
    assert_equal UnitStatus.active.count, 1
  end
end
