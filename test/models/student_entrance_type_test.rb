# frozen_string_literal: true

require 'test_helper'

class StudentEntranceTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = student_entrance_types(:dgs)
  end

  # relations
  has_many :prospective_students
end
