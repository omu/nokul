# frozen_string_literal: true

require 'test_helper'

class UnitInstructionTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  include ReferenceTestModule

  # relations
  has_many :units, dependent: :nullify
end
