# frozen_string_literal: true

require 'test_helper'

class StudentDisabilityTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = student_disability_types(:autism)
  end

  # relations
  has_many :prospective_students
end
