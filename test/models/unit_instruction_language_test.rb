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

  # validations: presence
  validates_presence_of :name
  validates_presence_of :code

  # validations: uniqueness
  validates_uniqueness_of :name
  validates_uniqueness_of :code

  # validations: length
  validates_length_of :name

  # validations: numericality
  validates_numericality_of(:code)
  validates_numerical_range(:code, :greater_than_or_equal_to, 0)
end
