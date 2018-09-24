# frozen_string_literal: true

require 'test_helper'

class UnitInstructionTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_instruction_types(:normal_education)
  end

  # relations
  test 'unit_instruction_type can communicate with units' do
    assert @object.units
  end
end
