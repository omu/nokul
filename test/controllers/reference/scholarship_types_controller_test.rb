# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class ScholarshipTypesControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest

  setup do
    @target_path = 'reference'
    @create_params = { name: 'Test Create', active: true }
    @update_params = { name: 'Test Update', active: false }
  end
end
