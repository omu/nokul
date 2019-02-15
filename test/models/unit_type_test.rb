# frozen_string_literal: true

require 'test_helper'

class UnitTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include EnumerationTestModule
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = unit_types(:university)
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

  # enums
  has_enum(
    {
      other: 0,
      faculty: 1,
      department: 2,
      major: 3,
      undergraduate_program: 4,
      graduate_program: 5,
      institute: 6,
      research_center: 7,
      committee: 8,
      administrative: 9
    }, 'group'
  )

  test 'senate scope returns types of senato' do
    assert_includes UnitType.senate, unit_types(:senate)
    assert_not_includes UnitType.senate, unit_types(:university)
  end
end
