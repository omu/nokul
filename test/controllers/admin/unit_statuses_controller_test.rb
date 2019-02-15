# frozen_string_literal: true

require 'test_helper'
require_relative '../concerns/references_resource_test'

class UnitStatusesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @variables = { name: 'Test Create', code: 999_998 }
  end

  include ReferenceResourceTest
end
