# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/references_resource_test'

class AssessmentMethodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @variables = { name: 'Test Create' }
  end

  include ReferenceResourceTest
end
