# frozen_string_literal: true

require 'test_helper'

class StudentEducationLevelTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = student_education_levels(:phd)
  end
end
