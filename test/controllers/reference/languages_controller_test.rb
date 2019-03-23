# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/reference_resource_test'

class LanguagesControllerTest < ActionDispatch::IntegrationTest
  include ReferenceResourceTest

  setup do
    @target_path = 'reference'
    @create_params = { name: 'Test Create', iso: 'TLC' }
    @update_params = { name: 'Test Update', iso: 'TLU' }
  end
end
