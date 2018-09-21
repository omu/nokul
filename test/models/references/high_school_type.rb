# frozen_string_literal: true

require 'test_helper'

class HighSchoolTypeTest < ActiveSupport::TestCase
  include ReferenceCallbacksTest
  include ReferenceValidationsTest

  # relations
  test 'high_school_type can communicate with prospective students' do
    assert high_schools(:aksam_lisesi).prospective_students
  end
end
