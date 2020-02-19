# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class CourseGroupTypesControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest

  setup do
    @target_path = 'reference'
    @create_params = { name: 'Course Group Type Create Test' }
    @update_params = { name: 'Course Group Type Update Test' }
  end
end
