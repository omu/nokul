# frozen_string_literal: true

require 'test_helper'

class UnitInstructionTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_instruction_types(:normal_education)
  end

  # relational tests
  test 'unit_instruction_type can communicate with units' do
    assert @object.units
  end

  # nullify tests
  test 'unit_instruction_type nullifies the related foreign key from unit when it gets deleted' do
    @object.destroy
    assert_nil units(:cbu).unit_instruction_type
  end
end
