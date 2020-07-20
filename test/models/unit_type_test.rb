# frozen_string_literal: true

require 'test_helper'

class UnitTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::EnumerationHelper
  include ReferenceTestModule

  # relations
  has_many :units, dependent: :nullify

  # enums
  enum group: {
    other:                 0,
    faculty:               1,
    department:            2,
    major:                 3,
    undergraduate_program: 4,
    graduate_program:      5,
    institute:             6,
    research_center:       7,
    committee:             8,
    administrative:        9
  }
end
