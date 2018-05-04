# frozen_string_literal: true

require 'test_helper'

class UnitTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_types(:university)
  end

  # relational tests
  test 'unit_type can communicate with units' do
    assert @object.units
  end

  # nullify tests
  test 'unit_type nullifies the related foreign key from unit when it gets deleted' do
    @object.destroy
    assert_nil units(:cbu).unit_type
  end
end
