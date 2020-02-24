# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class CourseTypesControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest

  setup do
    @target_path = 'reference'
    @create_params = { name: 'Course Type Create Test', code: 'CTT', min_credit: 1 }
    @update_params = { name: 'Course Type Update Test', code: 'UTT', min_credit: 2 }
  end
end
