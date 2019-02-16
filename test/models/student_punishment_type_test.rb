# frozen_string_literal: true

require 'test_helper'

class StudentPunishmentTypeTest < ActiveSupport::TestCase
  include ValidationTestModule
  include ReferenceTestModule

  setup do
    @object = student_punishment_types(:warning)
  end
end
