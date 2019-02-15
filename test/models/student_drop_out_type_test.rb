# frozen_string_literal: true

require 'test_helper'

class StudentDropOutTypeTest < ActiveSupport::TestCase
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = student_drop_out_types(:erasmus)
  end

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
