# frozen_string_literal: true

require 'test_helper'

class StudentStudentshipStatusTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = student_studentship_statuses(:can_be_a_student)
  end
end
