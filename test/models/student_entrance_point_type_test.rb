# frozen_string_literal: true

require 'test_helper'

class StudentEntrancePointTypeTest < ActiveSupport::TestCase
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = student_entrance_point_types(:mf1)
  end
end
