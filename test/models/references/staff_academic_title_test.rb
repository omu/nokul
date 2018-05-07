# frozen_string_literal: true

require 'test_helper'

class StaffAcademicTitleTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = staff_academic_titles(:professor)
  end
end
