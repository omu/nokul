# frozen_string_literal: true

require 'test_helper'

class UnitStatusTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_statuses(:passive)
  end

  # relational tests
  test 'unit_status can communicate with units' do
    assert @object.units
  end

  # nullify tests
  test 'unit_status nullifies the related foreign key from unit when it gets deleted' do
    @object.destroy
    assert_nil units(:cbu).unit_status
  end
end
