# frozen_string_literal: true

require 'test_helper'

class StudentGradeTest < ActiveSupport::TestCase
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = student_grades(:scientific_preparation)
  end
end
