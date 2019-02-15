# frozen_string_literal: true

require 'test_helper'

class StudentEducationLevelTest < ActiveSupport::TestCase
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = student_education_levels(:phd)
  end
end
