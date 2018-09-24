# frozen_string_literal: true

require 'test_helper'

class HighSchoolTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  setup do
    @object = high_schools_types(:aksam_lisesi)
  end

  # relations
  test 'high_school_type can communicate with prospective students' do
    assert high_schools_types(:aksam_lisesi).prospective_students
  end
end
