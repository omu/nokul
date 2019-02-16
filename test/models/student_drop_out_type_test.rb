# frozen_string_literal: true

require 'test_helper'

class StudentDropOutTypeTest < ActiveSupport::TestCase
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = student_drop_out_types(:erasmus)
  end
end
