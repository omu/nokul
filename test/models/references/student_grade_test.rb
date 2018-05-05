# frozen_string_literal: true

require 'test_helper'

class StudentGradeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = student_grades(:scientific_preparation)
  end
end
