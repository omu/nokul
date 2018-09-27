# frozen_string_literal: true

require 'test_helper'

class StudentEntranceTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = student_entrance_types(:dgs)
  end

  # relations
  test 'student_entrance_types can communicate with prospective students' do
    assert student_entrance_types(:dgs).prospective_students
  end
end
