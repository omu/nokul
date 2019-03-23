# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class TitlesControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest

  setup do
    @target_path = 'reference'
    @create_params = { name: 'Test Create', code: '4663', branch: 'GİH' }
    @update_params = { name: 'Test Update', code: '4664', branch: 'GİH' }
  end
end
