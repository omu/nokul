# frozen_string_literal: true

require 'test_helper'

class StudentGradingSystemTest < ActiveSupport::TestCase
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = student_grading_systems(:four_point_grading_system)
  end
end
