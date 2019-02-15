# frozen_string_literal: true

require 'test_helper'

class UnitInstructionLanguageTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = unit_instruction_languages(:english)
  end

  # relations
  has_many :units
end
