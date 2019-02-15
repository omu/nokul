# frozen_string_literal: true

require 'test_helper'

class UnitInstructionTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = unit_instruction_types(:normal_education)
  end

  # relations
  has_many :units
end
