# frozen_string_literal: true

require 'test_helper'

class StudentEntrancePointTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = student_entrance_point_types(:mf1)
  end
end
