# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class EvaluationTypesControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest

  setup do
    @target_path = 'reference'
    @create_params = { identifier: 'test_identifier', name: 'Test Create' }
    @update_params = { identifier: 'test_identifier', name: 'Test Update' }
  end
end
