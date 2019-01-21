# frozen_string_literal: true

require 'test_helper'

class UnitInstructionLanguageTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_instruction_languages(:english)
  end

  # relations
  test 'unit_instruction_language can communicate with units' do
    assert @object.units
  end
end
